import 'package:janari0_mobile/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_sale.g.dart';

@JsonSerializable()
class ProductSale {
  int? productSaleId = 1;
  Product? product;
  String? description = "";
  String price = "";
  ProductSale({required this.product, this.description, required this.price});

  factory ProductSale.fromJson(Map<String, dynamic> json) =>
      _$ProductSaleFromJson(json);

  /// Connect the generated [_$ProductSaleToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductSaleToJson(this);
}
