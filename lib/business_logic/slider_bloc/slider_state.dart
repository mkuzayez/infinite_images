part of 'slider_bloc.dart';

enum SliderStatus { initial, topicsLoaded, failure }

class SliderState extends Equatable {
  final SliderStatus status;
  final List<TopicObject> topics;

  const SliderState({
    this.status = SliderStatus.initial,
    this.topics = const [],
  });

  SliderState copyWith({
    SliderStatus? status,
    List<TopicObject>? topics,
  }) {
    return SliderState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
    );
  }

  @override
  List<Object?> get props => [status, topics];
}
