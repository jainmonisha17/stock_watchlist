import 'package:flutter/material.dart';
import 'package:flutter_trade_brains/models/company.dart';
import 'package:hive_flutter/adapters.dart';

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  final int typeId = 0;

  @override
  Company read(BinaryReader reader) {
    return Company(
      symbol: reader.readString(),
      name: reader.readString(),
      stockPrice: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Company obj) {
    writer.writeString(obj.symbol);
    writer.writeString(obj.name);
    writer.writeDouble(obj.stockPrice);
  }
}
