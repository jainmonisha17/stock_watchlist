import 'package:flutter/material.dart';
import 'package:flutter_trade_brains/models/models/company_adapter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/company.dart';
import 'package:flutter_trade_brains/models/company.dart';
import 'package:flutter_trade_brains/models/models/company.g.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Company>(CompanyAdapter());
  await Hive.openBox<Company>('watchlist');
  runApp(StockWatchlistApp());
}

class StockWatchlistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}






