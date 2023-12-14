import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookProvider {
  List<Book> books = [];
  late BuildContext context;

  Future<void> fetchBook() async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    String url = 'http://127.0.0.1:8000/book/json/';
    var response = await request.get(url);

    List<Book> listBooks = [];
    for (var d in json.decode(response.body)) {
      if (d != null) {
        listBooks.add(Book.fromJson(d));
      }
    }
    books = listBooks;
  }
}
