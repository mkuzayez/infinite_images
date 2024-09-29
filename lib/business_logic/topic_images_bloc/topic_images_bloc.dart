import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

part 'topic_images_event.dart';
part 'topic_images_state.dart';

class TopicImagesBloc extends Bloc<TopicImagesEvent, TopicImagesState> {
  final ImagesRepository imagesRepository;
  bool isLoadingMore = false;
  int page = 1;

  TopicImagesBloc(this.imagesRepository) : super(const TopicImagesState()) {
    on<FetchTopicImagesEvent>(getTopicImages);
    on<FetchMoreTopicImagesEvent>(fetchMoreTopicImages);
    on<ClearTopicImagesEvent>((event, emit) {
      emit(state.copyWith(topicImages: []));
    });
  }

  Future<void> getTopicImages(
      FetchTopicImagesEvent event, Emitter<TopicImagesState> emit) async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );
      page++;
      final topicImages = await imagesRepository.getTopicImages(
        event.topicId, page
      );
      emit(
        state.copyWith(
          status: Status.topicImagesLoaded,
          topicImages: topicImages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    }
  }

  Future<void> fetchMoreTopicImages(
      FetchMoreTopicImagesEvent event, Emitter<TopicImagesState> emit) async {
    if (isLoadingMore) return;
    isLoadingMore = true;

    try {
      emit(
        state.copyWith(
          status: Status.loadingMore,
        ),
      );
      page++;
      final newImages = await imagesRepository.getTopicImages(
        event.topicId, page
      );
      final updatedImages = List.of(state.topicImages)
        ..addAll(
          newImages,
        );
      emit(
        state.copyWith(
          status: Status.topicImagesLoaded,
          topicImages: updatedImages,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    } finally {
      isLoadingMore = false;
    }
  }
}
