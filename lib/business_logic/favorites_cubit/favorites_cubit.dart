import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/hive_storage.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final HiveStorage hiveStorage;

  FavoritesCubit(this.hiveStorage) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    List<ImageObject> favorites = await hiveStorage.loadFavorites();
    emit(
      state.copyWith(
        favoriteImages: favorites,
      ),
    );
  }

  Future<void> addFavorite(ImageObject image) async {
    if (state.favoriteImages.contains(image)) return;

    final updatedFavorites = List<ImageObject>.from(state.favoriteImages)
      ..add(image);
    emit(
      state.copyWith(
        favoriteImages: updatedFavorites,
      ),
    );

    await hiveStorage.addFavorite(image);
  }

  Future<void> deleteFavorite(ImageObject image) async {
    if (!state.favoriteImages.contains(image)) return;

    final updatedFavorites = List<ImageObject>.from(state.favoriteImages)
      ..remove(image);
    emit(state.copyWith(
      favoriteImages: updatedFavorites,
    ));

    await hiveStorage.deleteFavorite(image);
  }

  bool isFavorite(ImageObject image) {
    return state.favoriteImages.contains(image);
  }
}
