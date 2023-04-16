// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInsertRequest _$ProductInsertRequestFromJson(
        Map<String, dynamic> json) =>
    ProductInsertRequest(
      name: json['name'] as String,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => PhotoInsertRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$ProductInsertRequestToJson(
        ProductInsertRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'expirationDate': instance.expirationDate.toIso8601String(),
      'photos': instance.photos,
      'userId': instance.userId,
    };
