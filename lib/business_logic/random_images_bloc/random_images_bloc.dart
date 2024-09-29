import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

part 'random_images_event.dart';
part 'random_images_state.dart';

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  final ImagesRepository imagesRepository;
  List<ImageObject> randomImagesCache = [];
  bool isLoading = false;

  RandomImageBloc(this.imagesRepository) : super(const RandomImageState()) {
    on<FetchRandomImagesEvent>(getRandomImages);
    on<FetchMoreRandomImagesEvent>(loadMoreRandomImages);
  }

  Future<void> getRandomImages(
      FetchRandomImagesEvent event, Emitter<RandomImageState> emit) async {
    if (isLoading) return;
    isLoading = true;

    try {
      emit(state.copyWith(status: Status.loading));

      final newImages = await imagesRepository.getRandomImages();
      randomImagesCache = List.of(state.randomImages)..addAll(newImages);

      emit(
        state.copyWith(
          status: Status.randomImagesLoaded,
          randomImages: randomImagesCache,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
        ),
      );
    } finally {
      isLoading = false;
    }
  }

  Future<void> loadMoreRandomImages(
      FetchMoreRandomImagesEvent event, Emitter<RandomImageState> emit) async {
    if (isLoading) return; 
    isLoading = true;

    emit(state.copyWith(status: Status.loadingMore)); 

    try {
      final newImages = await imagesRepository.getRandomImages();
      randomImagesCache = List.of(state.randomImages)..addAll(newImages);

      emit(
        state.copyWith(
          status: Status.randomImagesLoaded,
          randomImages: randomImagesCache,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    } finally {
      isLoading = false;
    }
  }
}
