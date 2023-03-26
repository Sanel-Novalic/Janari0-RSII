// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )..productID = json['productID'] as int?;

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productID': instance.productID,
      'name': instance.name,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'photos': instance.photos,
    };
