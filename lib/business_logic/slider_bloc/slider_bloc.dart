import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';

part 'slider_event.dart';
part 'slider_state.dart';


class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final ImagesRepository imagesRepository;
  List<TopicObject> topicsCache = [];

  SliderBloc(this.imagesRepository) : super(const SliderState()) {
    on<FetchSliderTopicsEvent>(getTopics);
  }

  Future<void> getTopics(
      FetchSliderTopicsEvent event, Emitter<SliderState> emit) async {
    if (topicsCache.isNotEmpty) {
      emit(
        state.copyWith(
          status: SliderStatus.topicsLoaded,
          topics: topicsCache,
        ),
      );
      return;
    }

    try {
      final topics = await imagesRepository.getTopics();
      topicsCache = topics;
      emit(
        state.copyWith(
          status: SliderStatus.topicsLoaded,
          topics: topics,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: SliderStatus.failure,
        ),
      );
    }
  }
}