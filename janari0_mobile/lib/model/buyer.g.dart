// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buyer _$BuyerFromJson(Map<String, dynamic> json) => Buyer()
  ..buyerId = json['buyerId'] as int?
  ..status = json['status'] as bool?
  ..userId = json['userId'] as int?;

Map<String, dynamic> _$BuyerToJson(Buyer instance) => <String, dynamic>{
      'buyerId': instance.buyerId,
      'status': instance.status,
      'userId': instance.userId,
    };
