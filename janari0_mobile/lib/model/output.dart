import 'package:json_annotation/json_annotation.dart';

part 'output.g.dart';

@JsonSerializable()
class Output {
  int? outputId;
  DateTime? date;
  String? paymentMethod;
  bool? concluded;
  double? amount;
  String? receiptNumber;
  int? buyerId;
  int? orderId;

  Output();

  factory Output.fromJson(Map<String, dynamic> json) => _$OutputFromJson(json);

  /// Connect the generated [_$OutputToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OutputToJson(this);
}
