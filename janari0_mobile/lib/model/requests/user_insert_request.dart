import 'package:json_annotation/json_annotation.dart';

part 'user_insert_request.g.dart';

@JsonSerializable()
class UserInsertRequest {
  String? username;
  String? email;
  String? phoneNumber;
  UserInsertRequest() {}

  factory UserInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInsertRequestToJson(this);
}
