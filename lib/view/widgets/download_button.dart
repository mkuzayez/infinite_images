import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/download_cubit/download_cubit.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

class DownloadButton extends StatefulWidget {
  final ImageObject image;

  const DownloadButton({required this.image, super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool isExpanded = false;

  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });

    if (isExpanded) {
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isExpanded = false;
        });
      });
    }
  }

  Widget downloadIcon(BuildContext context) {
    return IconButton(
      iconSize: 18,
      icon: const Icon(
        Icons.file_download,
        shadows: [
          Shadow(
            color: Colors.black,
            blurRadius: 2,
          ),
        ],
      ),
      onPressed: toggleExpand,
      style: const ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size.zero),
        shape: WidgetStatePropertyAll(CircleBorder()),
        iconColor: WidgetStatePropertyAll(
          Color.fromARGB(255, 48, 63, 159),
        ),
      ),
    );
  }

  Widget resolutionOption(BuildContext context, String url, String resolution) {
    return TextButton(
      style: const ButtonStyle(
        shape: WidgetStatePropertyAll(CircleBorder()),
        minimumSize: WidgetStatePropertyAll(Size.zero),
      ),
      onPressed: () {
        context.read<DownloadCubit>().downloadImage(url);
      },
      child: Text(
        resolution,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResolutionOptions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        resolutionOption(
          context,
          widget.image.urls!.raw ??
              widget.image.urls!.full ??
              widget.image.urls!.regular!,
          "FHD",
        ),
        resolutionOption(
          context,
          widget.image.urls!.full ??
              widget.image.urls!.raw ??
              widget.image.urls!.regular!,
          "HD",
        ),
        resolutionOption(
          context,
          widget.image.urls!.regular ??
              widget.image.urls!.full ??
              widget.image.urls!.raw!,
          "SD",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DownloadCubit(),
      child: BlocConsumer<DownloadCubit, DownloadState>(
        listener: (context, state) {
          if (state.status == DownloadStatus.downloading) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.grey,
                content: Text(
                  'Download started..',
                  style: TextStyle(color: Color.fromARGB(255, 48, 63, 159)),
                ),
              ),
            );
          } else if (state.status == DownloadStatus.finishedDownloading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.grey,
                content: Text(
                  'Download finished successfully!',
                  style: TextStyle(color: Color.fromARGB(255, 48, 63, 159)),
                ),
              ),
            );
            context.read<DownloadCubit>().resetState();
          } else if (state.status == DownloadStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.grey,
                content: Text(
                  'Download failed, Please try again.',
                  style: TextStyle(color: Color.fromARGB(255, 48, 63, 159)),
                ),
              ),
            );
            context.read<DownloadCubit>().resetState();
          }
        },
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded
                    ? buildResolutionOptions(context)
                    : downloadIcon(context),
              ),
            ],
          );
        },
      ),
    );
  }
}
