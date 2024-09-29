part of 'search_bloc.dart';

enum Status { initial, searchResultsLoaded, failure, loading, loadingMore }

class SearchPhotosState extends Equatable {
  final Status status;
  final List<ImageObject> searchResults;

  const SearchPhotosState({
    this.status = Status.initial,
    this.searchResults = const [],
  });

  SearchPhotosState copyWith({
    Status? status,
    List<ImageObject>? searchResults,
  }) {
    return SearchPhotosState(
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object?> get props => [status, searchResults];
}
