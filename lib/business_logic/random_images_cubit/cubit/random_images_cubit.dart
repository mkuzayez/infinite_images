import 'package:bloc/bloc.dart';
import 'package:http_bloc_task2/business_logic/random_images_cubit/cubit/random_images_state.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/web_services/network_exceptions.dart';

class RandomImagesCubit extends Cubit<ResultState<List<ImageObject>>> {
  late ImagesRepository imagesRepository;
  RandomImagesCubit(this.imagesRepository) : super(const Idle());
  List<ImageObject> randomImagesCache = [];
  bool isLoading = false;

  Future<void> getRandomImages() async {
    if (isLoading) return;
    emit(const Loading());

    isLoading = true;

    var response = await imagesRepository.fetchRandomImages();
    response.when(
      success: (List<ImageObject> images) {
        emit(
          ResultState.success(
            images,
          ),
        );
      },
      failure: (NetworkExceptions networkException) {
        emit(
          ResultState.error(networkException),
        );
      },
    );
  }

  Future<void> loadMoreRandomImages() async {
    if (isLoading) return;
    isLoading = true;

    emit(const ResultState.loadingMore());

    var response = await imagesRepository.fetchRandomImages();

    response.when(
      success: (List<ImageObject> newImages) {
        randomImagesCache = List.of(randomImagesCache)..addAll(newImages);
        emit(ResultState.success(randomImagesCache));
      },
      failure: (NetworkExceptions networkException) {
        emit(ResultState.error(networkException));
      },
    );

    isLoading = false;
  }
}
