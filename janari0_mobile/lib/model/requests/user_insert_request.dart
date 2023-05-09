import 'package:janari0/model/requests/location_CU_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_insert_request.g.dart';

@JsonSerializable()
class UserInsertRequest {
  String username;
  String email;
  String phoneNumber;
  LocationCURequest location;
  UserInsertRequest(
      {required this.username,
      required this.email,
      required this.phoneNumber,
      required this.location});
  factory UserInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$UserInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserInsertRequestToJson(this);
}
