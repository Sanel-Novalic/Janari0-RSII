import 'package:janari0/model/product_sale.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderItem.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {
  int? orderItemId;
  int? orderId;
  int? productSaleId;
  ProductSale? product;

  OrderItem();

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  /// Connect the generated [_$OrderItemToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
