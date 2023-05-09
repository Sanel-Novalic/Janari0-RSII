import 'package:json_annotation/json_annotation.dart';

part 'seller.g.dart';

@JsonSerializable()
class Seller {
  int? sellerId;
  String? name;
  String? address;
  String? phoneNumber;
  String? website;

  Seller();

  factory Seller.fromJson(Map<String, dynamic> json) => _$SellerFromJson(json);

  /// Connect the generated [_$SellerToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SellerToJson(this);
}
