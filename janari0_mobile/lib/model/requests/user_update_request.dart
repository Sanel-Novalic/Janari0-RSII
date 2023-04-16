import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest {
  String? uid;
  String? username;
  String? email;
  String? phoneNumber;
  UserUpdateRequest({
    this.uid,
    this.username,
    this.email,
    this.phoneNumber,
  });
  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
