import 'package:janari0/model/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productId;
  String? name;
  DateTime? expirationDate;
  late List<Photo> photos;

  Product(
      {required this.productId,
      this.name,
      this.expirationDate,
      required this.photos});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static List<Product> fromJsonList(List list) {
    return list.map((item) => Product.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$productId $name';
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(Product model) {
    return productId == model.productId;
  }

  @override
  String toString() => name!;
}
