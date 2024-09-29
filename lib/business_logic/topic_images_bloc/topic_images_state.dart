part of 'topic_images_bloc.dart';

enum Status { initial, topicImagesLoaded, loading, failure }

class TopicImagesState extends Equatable {
  final Status status;
  final List<ImageObject> topicImages;

  const TopicImagesState({
    this.status = Status.initial,
    this.topicImages = const [],
  });

  TopicImagesState copyWith({
    Status? status,
    List<ImageObject>? topicImages,
  }) {
    return TopicImagesState(
      status: status ?? this.status,
      topicImages: topicImages ?? this.topicImages,
    );
  }

  @override
  List<Object?> get props => [status, topicImages];
}
