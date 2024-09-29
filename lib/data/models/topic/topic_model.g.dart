// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicObject _$TopicObjectFromJson(Map<String, dynamic> json) => TopicObject(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      totalPhotos: (json['total_photos'] as num?)?.toInt(),
      previewImages: (json['preview_photos'] as List<dynamic>?)
          ?.map((e) => PreviewImageObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicObjectToJson(TopicObject instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'total_photos': instance.totalPhotos,
      'preview_photos': instance.previewImages,
    };
