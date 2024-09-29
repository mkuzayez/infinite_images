import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchPhotosBloc extends Bloc<SearchPhotosEvent, SearchPhotosState> {
  final ImagesRepository imagesRepository;
  bool isLoading = false;
  int page = 1;

  SearchPhotosBloc(this.imagesRepository) : super(const SearchPhotosState()) {
    on<SearchForImagesEvent>(searchForImages);
    on<LoadMoreImagesEvent>(loadMoreImages);
    on<ClearImages>(clearImagesList);
  }

  Future<void> searchForImages(
      SearchForImagesEvent event, Emitter<SearchPhotosState> emit) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );

    page = 1;
    final results = await imagesRepository.searchImages(
      event.query,
      page,
    );

    emit(
      state.copyWith(
        status: Status.searchResultsLoaded,
        searchResults: results,
      ),
    );
  }

  Future<void> loadMoreImages(
      LoadMoreImagesEvent event, Emitter<SearchPhotosState> emit) async {
    if (isLoading) return;
    isLoading = true;

    emit(
      state.copyWith(
        status: Status.loadingMore,
      ),
    );

    page++;
    final results = await imagesRepository.searchImages(event.query, page);

    emit(
      state.copyWith(
        status: Status.searchResultsLoaded,
        searchResults: List.of(state.searchResults)..addAll(results),
      ),
    );

    isLoading = false;
  }

  Future<void> clearImagesList(
      ClearImages event, Emitter<SearchPhotosState> emit) async {
    emit(
      state.copyWith(
        status: Status.initial,
        searchResults: [],
      ),
    );
  }
}
