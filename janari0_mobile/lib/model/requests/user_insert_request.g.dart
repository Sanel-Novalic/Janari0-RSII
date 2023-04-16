// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInsertRequest _$UserInsertRequestFromJson(Map<String, dynamic> json) =>
    UserInsertRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      location:
          LocationCURequest.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInsertRequestToJson(UserInsertRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'location': instance.location,
    };
