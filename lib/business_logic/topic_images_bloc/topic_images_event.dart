part of 'topic_images_bloc.dart';


sealed class TopicImagesEvent extends Equatable {
  const TopicImagesEvent();
}

class FetchTopicImagesEvent extends TopicImagesEvent {
  final String topicId;

  const FetchTopicImagesEvent(this.topicId);

  @override
  List<Object> get props => [topicId];
}

class ClearTopicImagesEvent extends TopicImagesEvent {
  @override
  List<Object> get props => [];
}