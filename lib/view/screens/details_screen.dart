import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http_bloc_task2/business_logic/download_cubit/download_cubit.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsScreen extends StatelessWidget {
  final ImageObject image;

  const DetailsScreen({super.key, required this.image});

  Widget resolutionOption(BuildContext context, String url, String resolution) {
    return GestureDetector(
      onTap: () => context.read<DownloadCubit>().downloadImage(url),
      child: Text(
        resolution,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(
            255,
            48,
            63,
            159,
          ),
          shadows: [
            Shadow(
              color: Colors.black54,
              blurRadius: 0.5,
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
          image.urls!.raw ?? image.urls!.full ?? image.urls!.regular!,
          "RAW",
        ),
        const SizedBox(width: 10),
        resolutionOption(
          context,
          image.urls!.full ?? image.urls!.raw ?? image.urls!.regular!,
          "FULL",
        ),
        const SizedBox(width: 10),
        resolutionOption(
          context,
          image.urls!.regular ?? image.urls!.full ?? image.urls!.raw!,
          "REGULAR",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = image.width! / image.height!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(image.photoDescription!),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocListener<DownloadCubit, DownloadState>(
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (image.blurHash != null)
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / aspectRatio,
                        child: BlurHash(
                          hash: image.blurHash!,
                          imageFit: BoxFit.cover,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      Image.network(
                        image.urls!.regular!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / aspectRatio,
                      ),
                    ],
                  ),
                if (image.blurHash == null)
                  Stack(
                    children: [
                      FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / aspectRatio,
                        placeholder: kTransparentImage,
                        image: image.urls!.regular ?? image.urls!.full!,
                      ),
                    ],
                  ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Flexible(
                        child: Text(image.photoDescription ?? "Unavailable")),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Raw Height x Weight: "),
                    const Spacer(),
                    Text(
                        "${image.height ?? "Unavailable"} x ${image.width ?? "Unavailable"}"),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Uploader name: "),
                    const Spacer(),
                    Text(
                      image.user!.name ?? "Unavailable",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Uploader Instagram: "),
                    const Spacer(),
                    Text(
                      "@${image.user!.instagramUsername ?? "Unavailable"}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text("Download: "),
                    const Spacer(),
                    buildResolutionOptions(context)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
