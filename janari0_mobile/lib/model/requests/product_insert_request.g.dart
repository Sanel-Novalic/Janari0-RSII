// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInsertRequest _$ProductInsertRequestFromJson(
        Map<String, dynamic> json) =>
    ProductInsertRequest(
      name: json['name'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductInsertRequestToJson(
        ProductInsertRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'photos': instance.photos,
    };
