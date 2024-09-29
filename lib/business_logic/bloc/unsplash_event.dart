// part of 'unsplash_bloc.dart';


// sealed class UnsplashEvent extends Equatable {
//   const UnsplashEvent();

//   @override
//   List<Object?> get props => [];
// }

// class GenerateSliderEvent extends UnsplashEvent {}

// class GenerateRandomImagesEvent extends UnsplashEvent {}

// class FetchTopicImagesEvent extends UnsplashEvent {
//   final String topicId;

//   const FetchTopicImagesEvent(this.topicId);

//   @override
//   List<Object> get props => [topicId];
// }

// class ClearTopicImagesEvent extends UnsplashEvent {}

// class SearchPhotosEvent extends UnsplashEvent {
//   final String query;

//   const SearchPhotosEvent(this.query);

//   @override
//   List<Object> get props => [query];
// }