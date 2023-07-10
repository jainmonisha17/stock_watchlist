import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/company.dart';

class WatchlistScreen extends StatelessWidget {
  void removeFromWatchlist(BuildContext context, int index) {
    final watchlistBox = Hive.box<Company>('watchlist');
    watchlistBox.deleteAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Removed from watchlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchlistBox = Hive.box<Company>('watchlist');
    final watchlist = watchlistBox.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist - Watchlist'),
      ),
      body: ListView.builder(
        itemCount: watchlist.length,
        itemBuilder: (context, index) {
          final company = watchlist[index];
          return ListTile(
            title: Text(company.name),
            subtitle: Text(
              'Stock Price: \$${company.stockPrice.toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeFromWatchlist(context, index);
              },
            ),
          );
        },
      ),
    );
  }
}
