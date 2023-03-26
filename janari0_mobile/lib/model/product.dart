import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productID;
  String? name;
  DateTime? expirationDate;
  List<String>? photos;

  Product({this.name, this.expirationDate, this.photos});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
