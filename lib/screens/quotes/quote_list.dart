import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mutualibri/models/quotes_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuoteProvider extends ChangeNotifier {
  List<Quote> quotes = [];
  late BuildContext context;

  QuoteProvider(BuildContext context) {
    this.context = context;
    fetchQuotes(); // Panggil fetchQuotes saat instance QuoteProvider dibuat
  }

  Future<void> fetchQuotes() async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    String url = 'http://127.0.0.1:8000/quote/json/';
    var response = await request.get(url);

    List<Quote> listQuotes = [];
    for (var d in json.decode(response.body)) {
      if (d != null) {
        listQuotes.add(Quote.fromJson(d));
      }
    }

    quotes = listQuotes;
    notifyListeners();
  }

  List<String> get quoteTitles {
    return quotes.map((quote) => quote.fields.bookName).toList();
  }
}
