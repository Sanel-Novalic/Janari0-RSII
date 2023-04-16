// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sale_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSaleInsertRequest _$ProductSaleInsertRequestFromJson(
        Map<String, dynamic> json) =>
    ProductSaleInsertRequest(
      productId: json['productId'] as int,
      description: json['description'] as String?,
      price: json['price'] as String,
    )..product = json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>);

Map<String, dynamic> _$ProductSaleInsertRequestToJson(
        ProductSaleInsertRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'description': instance.description,
      'price': instance.price,
      'product': instance.product,
    };
