// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_CU_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationCURequest _$LocationCURequestFromJson(Map<String, dynamic> json) =>
    LocationCURequest(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationCURequestToJson(LocationCURequest instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
