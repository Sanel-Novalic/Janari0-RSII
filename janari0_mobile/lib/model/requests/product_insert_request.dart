import 'package:janari0/model/requests/photo_insert_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_insert_request.g.dart';

@JsonSerializable()
class ProductInsertRequest {
  String name;
  DateTime expirationDate;
  List<PhotoInsertRequest>? photos;
  int userId;
  ProductInsertRequest(
      {required this.name,
      required this.expirationDate,
      this.photos,
      required this.userId});

  factory ProductInsertRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductInsertRequestFromJson(json);

  /// Connect the generated [_$ProductInsertRequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductInsertRequestToJson(this);
}
