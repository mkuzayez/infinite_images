part of 'search_bloc.dart';

sealed class SearchPhotosEvent extends Equatable {
  const SearchPhotosEvent();
}

class SearchForImagesEvent extends SearchPhotosEvent {
  final String query;

  const SearchForImagesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreImagesEvent extends SearchPhotosEvent {
  final String query;

  const LoadMoreImagesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearImages extends SearchPhotosEvent {
  @override
  List<Object> get props => [];
}
