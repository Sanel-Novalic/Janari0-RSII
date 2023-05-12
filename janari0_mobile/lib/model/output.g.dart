// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Output _$OutputFromJson(Map<String, dynamic> json) => Output()
  ..outputId = json['outputId'] as int?
  ..date = json['date'] == null ? null : DateTime.parse(json['date'] as String)
  ..paymentMethod = json['paymentMethod'] as String?
  ..concluded = json['concluded'] as bool?
  ..amount = (json['amount'] as num?)?.toDouble()
  ..receiptNumber = json['receiptNumber'] as String?
  ..buyerId = json['buyerId'] as int?
  ..orderId = json['orderId'] as int?;

Map<String, dynamic> _$OutputToJson(Output instance) => <String, dynamic>{
      'outputId': instance.outputId,
      'date': instance.date?.toIso8601String(),
      'paymentMethod': instance.paymentMethod,
      'concluded': instance.concluded,
      'amount': instance.amount,
      'receiptNumber': instance.receiptNumber,
      'buyerId': instance.buyerId,
      'orderId': instance.orderId,
    };
