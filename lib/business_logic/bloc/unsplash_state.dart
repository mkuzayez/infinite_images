// part of 'unsplash_bloc.dart';

// enum Status {
//   initial,
//   loading,
//   success,
//   failure,
//   randomImagesLoaded,
//   topicsLoaded,
//   topicImagesLoaded,
//   searchResultsLoaded
// }

// class UnsplashState extends Equatable {
//   final Status status;
//   final List<ImageObject> randomImages;
//   final List<TopicObject> topics;
//   final List<ImageObject> topicImages;
//   final List<ImageObject> searchResults;

//   const UnsplashState({
//     this.status = Status.initial,
//     this.randomImages = const [],
//     this.topics = const [],
//     this.topicImages = const [],
//     this.searchResults = const [],
//   });

//   UnsplashState copyWith({
//     Status? status,
//     List<ImageObject>? randomImages,
//     List<TopicObject>? topics,
//     List<ImageObject>? topicImages,
//     List<ImageObject>? searchResults,
//   }) {
//     return UnsplashState(
//       status: status ?? this.status,
//       randomImages: randomImages ?? this.randomImages,
//       topics: topics ?? this.topics,
//       topicImages: topicImages ?? this.topicImages,
//       searchResults: searchResults ?? this.searchResults,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [status, randomImages, topics, topicImages, searchResults];
// }
