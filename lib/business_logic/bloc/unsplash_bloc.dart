// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http_bloc_task2/data/images_repository.dart';
// import 'package:http_bloc_task2/data/models/image/image_model.dart';
// import 'package:http_bloc_task2/data/models/topic/topic_model.dart';

// part 'unsplash_event.dart';
// part 'unsplash_state.dart';

// class UnsplashBloc extends Bloc<UnsplashEvent, UnsplashState> {
//   final ImagesRepository imagesRepository;

//   UnsplashBloc(this.imagesRepository) : super(const UnsplashState()) {
//     on<GenerateRandomImagesEvent>(getRandomImages);
//     on<GenerateSliderEvent>(getTopics);
//     on<FetchTopicImagesEvent>(getTopicImages);
//     on<ClearTopicImagesEvent>((event, emit) {
//       emit(state.copyWith(topicImages: []));
//     });
//     on<SearchPhotosEvent>(searchForImages);
//   }

//   List<ImageObject> randomImagesCache = [];
//   List<TopicObject> topicsCache = [];

//   bool isLoading = false;

//   Future<void> getTopics(
//       GenerateSliderEvent event, Emitter<UnsplashState> emit) async {
//     if (topicsCache.isNotEmpty) {
//       emit(
//         state.copyWith(
//           status: Status.topicsLoaded,
//           topics: topicsCache,
//         ),
//       );
//       return;
//     }

//     try {
//       final topics = await imagesRepository.getTopics();
//       topicsCache = topics;
//       emit(
//         state.copyWith(
//           status: Status.topicsLoaded,
//           topics: topics,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: Status.failure,
//         ),
//       );
//     }
//   }

//   Future<void> getRandomImages(
//       GenerateRandomImagesEvent event, Emitter<UnsplashState> emit) async {
//     if (isLoading) return;
//     isLoading = true;
//     try {
//       final newImages = await imagesRepository.getRandomImages();
//       randomImagesCache = List.of(state.randomImages)..addAll(newImages);
//       emit(
//         state.copyWith(
//           status: Status.randomImagesLoaded,
//           randomImages: randomImagesCache,
//         ),
//       );
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: Status.failure,
//         ),
//       );
//     } finally {
//       isLoading = false;
//     }
//   }

//   Future<void> getTopicImages(
//       FetchTopicImagesEvent event, Emitter<UnsplashState> emit) async {
//     try {
//       emit(
//         state.copyWith(
//           status: Status.loading,
//         ),
//       );

//       final topicImages = await imagesRepository.getTopicImages(event.topicId);
//       emit(
//         state.copyWith(
//           status: Status.topicImagesLoaded,
//           topicImages: topicImages,
//         ),
//       );
//     } catch (error) {
//       emit(
//         state.copyWith(
//           status: Status.failure,
//         ),
//       );
//     }
//   }

//   Future<void> searchForImages(
//       SearchPhotosEvent event, Emitter<UnsplashState> emit) async {

//     final results = await imagesRepository.searchImages(event.query);

//     emit(
//       state.copyWith(
//         status: Status.searchResultsLoaded,
//         searchResults: results,
//       ),
//     );
//   }
// }
