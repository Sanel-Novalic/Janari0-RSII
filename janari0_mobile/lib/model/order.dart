import 'package:json_annotation/json_annotation.dart';

import 'orderItem.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  int? orderId;
  String? orderNumber;
  int? buyerId;
  String? date;
  bool? status;
  bool? canceled;
  double? price;
  List<OrderItem>? orderItems;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Connect the generated [_$OrderToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
