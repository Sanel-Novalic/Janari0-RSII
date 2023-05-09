// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seller _$SellerFromJson(Map<String, dynamic> json) => Seller()
  ..sellerId = json['sellerId'] as int?
  ..name = json['name'] as String?
  ..address = json['address'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..website = json['website'] as String?;

Map<String, dynamic> _$SellerToJson(Seller instance) => <String, dynamic>{
      'sellerId': instance.sellerId,
      'name': instance.name,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'website': instance.website,
    };
