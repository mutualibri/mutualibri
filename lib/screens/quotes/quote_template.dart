import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mutualibri/models/quotes_model.dart';
import 'package:mutualibri/screens/quotes/quote_form.dart';
import 'package:mutualibri/screens/quotes/quote_null.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  Future<List<Quote>> fetchQuote() async {
    final request = context.watch<CookieRequest>();
    String url = 'http://127.0.0.1:8000/quote/json/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Quote
    List<Quote> list_Quote = [];
    for (var d in response) {
      if (d != null) {
        list_Quote.add(Quote.fromJson(d));
      }
    }
    return list_Quote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Quote',
            ),
          ),
          backgroundColor: Color.fromARGB(255, 251, 207, 103),
          foregroundColor: Colors.white,
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Your Daily Dose of Quote",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 241, 188, 74)),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuoteForm(),
                      ),
                    );
                  },
                  child: const Text(
                    "add your quote here!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchQuote(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return QuoteNull();
                  } else {
                    if (!snapshot.hasData) {
                      return QuoteNull();
                    } else {
                      return Container(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Ubah nilai sesuai keinginan Anda
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            "${snapshot.data![index].fields.bookName}",
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.black,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                        ),
                                        Center(
                                          child: Text(
                                              "${snapshot.data![index].fields.quotes}"),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                "@${snapshot.data![index].fields.username}"),
                                            // Tambahkan widget lain di sini jika diperlukan
                                          ],
                                        ),
                                      ],
                                    ),
                                  )));
                    }
                  }
                }),
          )
        ]));
  }
}
