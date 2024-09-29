import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/share_cubit/share_cubit.dart';

class ShareImageButton extends StatelessWidget {
  final String imageUrl;

  const ShareImageButton({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareImageCubit(),
      child: Builder(builder: (context) {
        return BlocListener<ShareImageCubit, ShareImageState>(
          listener: (context, state) {
            if (state.status == ShareStatus.sharing) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.grey,
                  content: Text(
                    'Preparing the share process. Hang on a second.',
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        48,
                        63,
                        159,
                      ),
                    ),
                  ),
                ),
              );
            } else if (state.status == ShareStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.grey,
                  content: Text(
                    'Failed to share image. Please try again.',
                    style: TextStyle(
                      color: Color.fromARGB(
                        255,
                        48,
                        63,
                        159,
                      ),
                    ),
                  ),
                ),
              );
              context.read<ShareImageCubit>().resetState();
            }
          },
          child: IconButton(
            style: const ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size.zero),
              shape: WidgetStatePropertyAll(CircleBorder()),
              iconColor: WidgetStatePropertyAll(
                Color.fromARGB(255, 48, 63, 159),
              ),
            ),
            iconSize: 18,
            onPressed: () {
              context.read<ShareImageCubit>().shareImage(imageUrl);
            },
            icon: const Icon(
              Icons.share,
              shadows: [
                Shadow(
                  color: Colors.black,
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
