import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/company.dart';
import 'watchlist_screen.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  List<Company> searchResults = [];

  Future<void> fetchCompanies(String searchQuery) async {
    final apiKey = '4AEBFVMC2BLZO28P';
    final url =
        'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$searchQuery&apikey=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final searchResultsData = jsonData['bestMatches'] as List<dynamic>;
      final List<Company> results = searchResultsData.map((companyJson) {
        return Company(
          symbol: companyJson['1. symbol'],
          name: companyJson['2. name'],
          stockPrice: double.parse(companyJson['5. price']),
        );
      }).toList();
      setState(() {
        searchResults = results;
      });
    } else {
      throw Exception('Failed to fetch companies');
    }
  }

  void addToWatchlist(Company company) {
    final watchlistBox = Hive.box<Company>('watchlist');
    watchlistBox.add(company);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Added to watchlist')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist - Home'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
                fetchCompanies(searchQuery);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final company = searchResults[index];
                return ListTile(
                  title: Text(company.name),
                  subtitle: Text(
                      'Stock Price: \$${company.stockPrice.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      addToWatchlist(company);
                    },
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WatchlistScreen()),
              );
            },
            child: Text('Go to Watchlist'),
          ),
        ],
      ),
    );
  }
}
