import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/view/widgets/image_widget.dart';



class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesCubit>().loadFavorites();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Favorite Images'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.favoriteImages.isEmpty) {
              return const Center(
                child: Text("No favorites yet"),
              );
            }
            return ListView.builder(
              itemCount: state.favoriteImages.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final image = state.favoriteImages[index];
                final aspectRatio = image.width! / image.height!;
        
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.width / aspectRatio,
                  child: ImageWidget(
                    image: image,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
