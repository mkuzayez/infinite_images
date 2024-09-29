import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';
part 'image_model.g.dart';

// @JsonSerializable()
// class ImageObject {
//   final String? slug;
//   @JsonKey(name: "blur_hash")
//   final String? blurHash;
//   @JsonKey(name: "alt_description")
//   final String? photoDescription;
//   final int? height;
//   final int? width;
//   final Urls? urls;
//   final Links? links;
//   final User? user;

//   ImageObject({
//     required this.slug,
//     required this.blurHash,
//     required this.photoDescription,
//     required this.height,
//     required this.width,
//     required this.urls,
//     required this.links,
//     required this.user,
//   });

//   factory ImageObject.fromJson(Map<String, dynamic> json) =>
//       _$ImageObjectFromJson(json);

//   Map<String, dynamic> toJson() => _$ImageObjectToJson(this);
// }

// @JsonSerializable()
// class Urls {
//   final String? raw;
//   final String? full;
//   final String? regular;

//   const Urls({
//     this.raw,
//     this.full,
//     this.regular,
//   });

//   factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

//   Map<String, dynamic> toJson() => _$UrlsToJson(this);
// }

// @JsonSerializable()
// class Links {
//   @JsonKey(name: "download_location")
//   final String? downloadLink;

//   const Links({
//     this.downloadLink,
//   });

//   factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

//   Map<String, dynamic> toJson() => _$LinksToJson(this);
// }

// @JsonSerializable()
// class User {
//   final String? name;
//   @JsonKey(name: "instagram_username")
//   final String? instagramUsername;

//   const User({
//     required this.name,
//     required this.instagramUsername,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }

@HiveType(typeId: 0)
@JsonSerializable()
class ImageObject {
  @HiveField(0)
  final String? slug;

  @HiveField(1)
  @JsonKey(name: "blur_hash")
  final String? blurHash;

  @HiveField(2)
  @JsonKey(name: "alt_description")
  final String? photoDescription;

  @HiveField(3)
  final int? height;

  @HiveField(4)
  final int? width;

  @HiveField(5)
  final Urls? urls;

  @HiveField(6)
  final Links? links;

  @HiveField(7)
  final User? user;

  ImageObject({
    this.slug,
    this.blurHash,
    this.photoDescription,
    this.height,
    this.width,
    this.urls,
    this.links,
    this.user,
  });

  factory ImageObject.fromJson(Map<String, dynamic> json) =>
      _$ImageObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ImageObjectToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()

class Urls {
  @HiveField(0)
  final String? raw;

  @HiveField(1)
  final String? full;

  @HiveField(2)
  final String? regular;

  const Urls({
    this.raw,
    this.full,
    this.regular,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()

class Links {
  @HiveField(0)
  @JsonKey(name: "download_location")
  final String? downloadLink;

  const Links({
    this.downloadLink,
  });

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@HiveType(typeId: 3)
@JsonSerializable()

class User {
  @HiveField(0)
  final String? name;

  @HiveField(1)
  @JsonKey(name: "instagram_username")
  final String? instagramUsername;

  const User({
    this.name,
    this.instagramUsername,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
