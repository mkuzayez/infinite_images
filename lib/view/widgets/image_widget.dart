import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/view/widgets/download_button.dart';
// ignore: unused_import
import 'package:http_bloc_task2/view/widgets/share_button.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWidget extends StatelessWidget {
  final ImageObject image;

  const ImageWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final aspectRatio = image.width! / image.height!;
    final isFavorited = context.watch<FavoritesCubit>().isFavorite(image);

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed('/details', arguments: image),
      child: image.blurHash != null
          ? Stack(
              children: [
                BlurHash(
                  hash: image.blurHash!,
                  imageFit: BoxFit.cover,
                  curve: Curves.easeInOut,
                ),
                Image.network(
                  image.urls!.regular!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / aspectRatio,
                ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  left: 50,
                  child: buildDescription(image),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  child: DownloadButton(
                    image: image,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: IconButton(
                    icon: Icon(
                      isFavorited ? Icons.star : Icons.star_border,
                      color: isFavorited
                          ? const Color.fromARGB(255, 48, 63, 159)
                          : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorited) {
                        context.read<FavoritesCubit>().deleteFavorite(image);
                      } else {
                        context.read<FavoritesCubit>().addFavorite(image);
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 3,
                  child: ShareImageButton(
                    imageUrl: image.urls!.regular!,
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                FadeInImage.memoryNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / aspectRatio,
                  placeholder: kTransparentImage,
                  image: image.urls!.regular ?? image.urls!.full!,
                ),
                Positioned(
                  bottom: 10,
                  right: 50,
                  left: 50,
                  child: buildDescription(image),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  child: DownloadButton(
                    image: image,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: IconButton(
                    icon: Icon(
                      isFavorited ? Icons.star : Icons.star_border,
                      color: isFavorited ? Colors.yellow : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorited) {
                        context.read<FavoritesCubit>().deleteFavorite(image);
                      } else {
                        context.read<FavoritesCubit>().addFavorite(image);
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 3,
                  child: ShareImageButton(
                    imageUrl: image.urls!.regular!,
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildDescription(ImageObject image) {
    return Container(
      width: double.infinity,
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: image.photoDescription != null
            ? Text(
                "${image.photoDescription}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )
            : const Text(
                "Description is unavailable",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
