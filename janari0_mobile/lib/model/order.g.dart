// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order()
  ..orderId = json['orderId'] as int?
  ..orderNumber = json['orderNumber'] as String?
  ..buyerId = json['buyerId'] as int?
  ..date = json['date'] as String?
  ..status = json['status'] as bool?
  ..canceled = json['canceled'] as bool?
  ..price = (json['price'] as num?)?.toDouble()
  ..orderItems = (json['orderItems'] as List<dynamic>?)
      ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'orderNumber': instance.orderNumber,
      'buyerId': instance.buyerId,
      'date': instance.date,
      'status': instance.status,
      'canceled': instance.canceled,
      'price': instance.price,
      'orderItems': instance.orderItems?.map((e) => e.toJson()).toList(),
    };
