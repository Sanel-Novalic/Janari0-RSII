// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSale _$ProductSaleFromJson(Map<String, dynamic> json) => ProductSale(
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    description: json['description'] as String?,
    price: json['price'] as String,
    productSaleId: json['productSaleId'] as int?);

Map<String, dynamic> _$ProductSaleToJson(ProductSale instance) =>
    <String, dynamic>{
      'productSaleId': instance.productSaleId,
      'product': instance.product,
      'description': instance.description,
      'price': instance.price,
    };
