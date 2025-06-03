import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/quote.dart';

class QuoteProvider extends ChangeNotifier{

  final List<Quote> _quotes = [
    Quote(id: 1, text: "Believe in yourself!", author: "Unknown"),
    Quote(id: 2, text: "You can do it.", author: "Shia LaBeouf"),
    Quote(id: 3, text: "Stay positive.", author: "Unknown"),
    Quote(id: 4, text: "Success is no accident.", author: "Pele"),
    // Add more quotes here
  ];

  Quote? _dailyQuote;

  QuoteProvider() {
    _loadDailyQuote();
  }

  Quote? get dailyQuote => _dailyQuote;

  List<Quote> get favorites => _quotes.where((q) => q.isFavorite).toList();

  void toggleFavorite(Quote quote) {
    quote.isFavorite = !quote.isFavorite;
    notifyListeners();
  }

  void _loadDailyQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getInt('dailyQuoteId');
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final savedDate = prefs.getString('dailyQuoteDate');

    if (savedId != null && savedDate == today) {
      _dailyQuote = _quotes.firstWhere((q) => q.id == savedId);
    } else {
      _dailyQuote = _quotes[Random().nextInt(_quotes.length)];
      await prefs.setInt('dailyQuoteId', _dailyQuote!.id);
      await prefs.setString('dailyQuoteDate', today);
    }
    notifyListeners();
  }

}