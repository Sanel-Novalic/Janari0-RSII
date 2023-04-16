import 'package:json_annotation/json_annotation.dart';

part 'photo_insert_request.g.dart';

@JsonSerializable()
class PhotoInsertRequest {
  String? link;

  PhotoInsertRequest({this.link});

  factory PhotoInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$PhotoInsertRequestFromJson(json);

  /// Connect the generated [_$UserInsertRequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PhotoInsertRequestToJson(this);
}
