part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final List<ImageObject> favoriteImages;

  const FavoritesState({
    this.favoriteImages = const [],
  });

  FavoritesState copyWith({
    List<ImageObject>? favoriteImages,
  }) {
    return FavoritesState(
      favoriteImages: favoriteImages ?? this.favoriteImages,
    );
  }

  @override
  List<Object?> get props => [favoriteImages];
}
