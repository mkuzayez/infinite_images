part of 'random_images_bloc.dart';


sealed class RandomImageEvent extends Equatable {
  const RandomImageEvent();
}

class FetchRandomImagesEvent extends RandomImageEvent {
  @override
  List<Object> get props => [];
}

class FetchMoreRandomImagesEvent extends RandomImageEvent {
  @override
  List<Object> get props => [];
}