import 'package:json_annotation/json_annotation.dart';

part 'product_insert_request.g.dart';

@JsonSerializable()
class ProductInsertRequest {
  String? name;
  DateTime? expirationDate;
  List<String>? photos;

  ProductInsertRequest({this.name, this.expirationDate, this.photos});

  factory ProductInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductInsertRequestFromJson(json);

  /// Connect the generated [_$UserInsertRequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductInsertRequestToJson(this);
}
