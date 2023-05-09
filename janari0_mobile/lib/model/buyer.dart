import 'package:json_annotation/json_annotation.dart';

part 'buyer.g.dart';

@JsonSerializable()
class Buyer {
  int? buyerId;
  bool? status;
  int? userId;

  Buyer();

  factory Buyer.fromJson(Map<String, dynamic> json) => _$BuyerFromJson(json);

  /// Connect the generated [_$BuyerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BuyerToJson(this);
}
