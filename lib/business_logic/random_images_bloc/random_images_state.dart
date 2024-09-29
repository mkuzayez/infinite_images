part of 'random_images_bloc.dart';

enum Status { initial, randomImagesLoaded, failure, loading, loadingMore }

class RandomImageState extends Equatable {
  final Status status;
  final List<ImageObject> randomImages;

  const RandomImageState({
    this.status = Status.initial,
    this.randomImages = const [],
  });

  RandomImageState copyWith({
    Status? status,
    List<ImageObject>? randomImages,
  }) {
    return RandomImageState(
      status: status ?? this.status,
      randomImages: randomImages ?? this.randomImages,
    );
  }

  @override
  List<Object?> get props => [status, randomImages];
}
