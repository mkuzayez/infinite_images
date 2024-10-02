import 'package:json_annotation/json_annotation.dart';
part 'error.g.dart';


@JsonSerializable()
class ErrorModel {
  final List<String>? errors;

  ErrorModel(this.errors);

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this); 
}
