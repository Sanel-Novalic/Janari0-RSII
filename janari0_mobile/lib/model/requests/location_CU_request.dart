import 'package:json_annotation/json_annotation.dart';

part 'location_CU.g.dart';

@JsonSerializable()
class LocationCURequest {
  double latitude;
  double longitude;

  LocationCURequest({required this.latitude, required this.longitude});

  factory LocationCURequest.fromJson(Map<String, dynamic> json) =>
      _$LocationCURequestFromJson(json);

  /// Connect the generated [_$LocationCURequestToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LocationCURequestToJson(this);
}
