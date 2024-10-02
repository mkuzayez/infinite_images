import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_bloc_task2/data/web_services/network_exceptions.dart';

part 'random_images_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = Idle<T>;

  const factory ResultState.loading() = Loading<T>;

  const factory ResultState.success(T data) = Success<T>;

  const factory ResultState.loadingMore() = LoadingMore<T>;

  const factory ResultState.error(NetworkExceptions networkExceptions) =
      Error<T>;
}
