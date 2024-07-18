import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/newsListData.dart';

class NewsProvider with ChangeNotifier {
  List<NewsListData> _newsData = [];
  bool _loading = false;

  List<NewsListData> get items => _newsData;
  bool get loading => _loading;

  Future<void> fetchItems() async {
    _loading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2024-06-17&sortBy=publishedAt&apiKey=00a3bb0bad3c4dbbb7f644fde89befe2'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _newsData = data.map((item) => NewsListData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }

    _loading = false;
    notifyListeners();
  }
}