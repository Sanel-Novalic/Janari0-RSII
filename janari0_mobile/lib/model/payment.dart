import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  String? paymentMethodNonce;
  double? amount;
  int? buyerId;
  bool? successful;
  int? productSaleId;

  Payment();

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  /// Connect the generated [_$PaymentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
