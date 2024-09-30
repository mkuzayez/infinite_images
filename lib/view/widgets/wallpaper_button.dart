import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/wallpaper_cubit/wallpaper_cubit.dart';

class SetWallpaperButton extends StatelessWidget {
  final String imageUrl;

  const SetWallpaperButton({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WallpaperCubit(),
      child: Builder(builder: (context) {
        return GestureDetector(
          child: const Text(
            "Set as wallpaper",
            style: TextStyle(
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
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => showWallpaperOptions(context, imageUrl),
        );
      }),
    );
  }

  void showWallpaperOptions(BuildContext context, String imageUrl) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: BlocProvider.value(
            value: BlocProvider.of<WallpaperCubit>(context),
            child: BlocListener<WallpaperCubit, WallpaperState>(
              listener: (context, state) {
                if (state.status == WallpaperStatus.success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Wallpaper set successfully!',
                      ),
                    ),
                  );
                } else if (state.status == WallpaperStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Failed to set wallpaper.',
                      ),
                    ),
                  );
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    child: Text(
                      "Set for Home Screen",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: () {
                      context
                          .read<WallpaperCubit>()
                          .setWallpaper(imageUrl, WallpaperType.home);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: Text(
                      "Set for Lock Screen",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: () {
                      context
                          .read<WallpaperCubit>()
                          .setWallpaper(imageUrl, WallpaperType.lock);
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    child: Text(
                      "Set for Both Screens",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: () {
                      context
                          .read<WallpaperCubit>()
                          .setWallpaper(imageUrl, WallpaperType.both);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildOption(
      BuildContext context, String label, WallpaperType type, String imageUrl) {
    return Column(
      children: [
        TextButton(
          child: Text(label),
          onPressed: () =>
              context.read<WallpaperCubit>().setWallpaper(imageUrl, type),
        ),
      ],
    );
  }
}
