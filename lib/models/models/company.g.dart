// GENERATED CODE - DO NOT MODIFY BY HAND


import 'package:flutter_trade_brains/models/company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) {
  return Company(
    symbol: json['symbol'] as String,
    name: json['name'] as String,
    stockPrice: (json['stockPrice'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'stockPrice': instance.stockPrice,
    };
