// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem()
  ..orderItemId = json['orderItemId'] as int?
  ..orderId = json['orderId'] as int?
  ..productSaleId = json['productSaleId'] as int?
  ..product = json['product'] == null
      ? null
      : ProductSale.fromJson(json['product'] as Map<String, dynamic>);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'orderItemId': instance.orderItemId,
      'orderId': instance.orderId,
      'productSaleId': instance.productSaleId,
      'product': instance.product?.toJson(),
    };
