import 'package:json_annotation/json_annotation.dart';

part 'preview_image_model.g.dart';

@JsonSerializable()
class PreviewImageObject {
  final String? slug;
  @JsonKey(name: "blur_hash")
  final String? blurHash;
  final Urls? urls;

  PreviewImageObject({
    required this.slug,
    required this.blurHash,
    required this.urls,
  });

  factory PreviewImageObject.fromJson(Map<String, dynamic> json) =>
      _$PreviewImageObjectFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewImageObjectToJson(this);
}

@JsonSerializable()
class Urls {
  final String? raw;
  final String? full;
  final String? regular;

  const Urls({
    this.raw,
    this.full,
    this.regular,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}
