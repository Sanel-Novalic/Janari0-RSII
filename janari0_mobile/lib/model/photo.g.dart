// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      link: json['link'] as String?,
    )..photoID = json['photoID'] as int?;

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'photoID': instance.photoID,
      'link': instance.link,
    };
