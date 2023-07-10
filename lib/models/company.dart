import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_trade_brains/models/models/company.g.dart';

import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class Company extends HiveObject {
  @HiveField(0)
  final String symbol;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double stockPrice;

  Company({
    required this.symbol,
    required this.name,
    required this.stockPrice,
  });

  
}
