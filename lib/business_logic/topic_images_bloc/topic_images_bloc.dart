import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

part 'topic_images_event.dart';
part 'topic_images_state.dart';

class TopicImagesBloc extends Bloc<TopicImagesEvent, TopicImagesState> {
  final ImagesRepository imagesRepository;

  TopicImagesBloc(this.imagesRepository) : super(const TopicImagesState()) {
    on<FetchTopicImagesEvent>(getTopicImages);
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

      final topicImages = await imagesRepository.getTopicImages(event.topicId);
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
}
