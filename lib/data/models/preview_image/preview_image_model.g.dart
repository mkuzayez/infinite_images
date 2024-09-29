// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewImageObject _$PreviewImageObjectFromJson(Map<String, dynamic> json) =>
    PreviewImageObject(
      slug: json['slug'] as String?,
      blurHash: json['blur_hash'] as String?,
      urls: json['urls'] == null
          ? null
          : Urls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreviewImageObjectToJson(PreviewImageObject instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'blur_hash': instance.blurHash,
      'urls': instance.urls,
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      raw: json['raw'] as String?,
      full: json['full'] as String?,
      regular: json['regular'] as String?,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
    };
