// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..userID = json['userID'] as int?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
  ..phoneNumber = json['phoneNumber'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userID': instance.userID,
      'username': instance.username,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
    };
