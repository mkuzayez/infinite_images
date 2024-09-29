import 'package:http_bloc_task2/data/models/preview_image/preview_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicObject {
  final String? title;
  final String? slug;
  final String? description;
  @JsonKey(name: "total_photos")
  final int? totalPhotos;
  @JsonKey(name: "preview_photos")
  final List<PreviewImageObject>? previewImages;

  TopicObject({
    required this.title,
    required this.slug,
    required this.description,
    required this.totalPhotos,
    required this.previewImages,
  });

  factory TopicObject.fromJson(Map<String, dynamic> json) =>
      _$TopicObjectFromJson(json);

  Map<String, dynamic> toJson() => _$TopicObjectToJson(this);
}
