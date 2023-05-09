import 'package:json_annotation/json_annotation.dart';

import '../product.dart';

part 'product_sale_insert_request.g.dart';

@JsonSerializable()
class ProductSaleInsertRequest {
  int productId;
  String? description;
  String price;
  Product? product;
  int locationId;
  ProductSaleInsertRequest(
      {required this.productId,
      this.description,
      required this.price,
      required this.locationId});

  factory ProductSaleInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductSaleInsertRequestFromJson(json);

  /// Connect the generated [_$ProductSaleInsertRequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductSaleInsertRequestToJson(this);
}
