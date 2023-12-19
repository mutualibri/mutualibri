// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:mutualibri/models/quotes_model.dart';
import 'package:mutualibri/screens/quotes/quote_form.dart';
import 'package:mutualibri/screens/quotes/quote_null.dart';
import 'package:mutualibri/widgets/drawer.dart';
import 'package:mutualibri/widgets/catalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  // List<Book> books = [];

  Future<List<Quote>> fetchQuote() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/quote/json/';
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

  // Future<List<Book>> fetchBook() async {
  //   final request = context.watch<CookieRequest>();
  //   String url = 'http://127.0.0.1:8000/book/json/';
  //   var response = await request.get(url);

  //   List<Book> listBooks = [];
  //   for (var d in json.decode(response.body)) {
  //     if (d != null) {
  //       listBooks.add(Book.fromJson(d));
  //     }
  //   }
  //   books = listBooks;
  //   return listBooks;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFfbb825),
          title: const Text(
            'Quotes of Books',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'assets/images/Logo.png',
                height: 50,
                width: 50,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CatalogTemplate()),
                );
              },
            ),
          ],
        ),
        drawer: const DrawerClass(),
        body: Center(
          child: FutureBuilder(
              future: fetchQuote(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return QuoteNull();
                } else {
                  return Container(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (_, index) {
                            if (index == 0) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20.0),
                                      child: const Center(
                                        child: Text(
                                          "Your Daily Dose of Quotes",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color.fromARGB(
                                                          255, 241, 188, 74)),
                                            ),
                                            onPressed: () async {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const QuoteForm(),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "add your quote here!",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "${snapshot.data![index - 1].fields.bookName}",
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
                                          "${snapshot.data![index - 1].fields.quotes}"),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            "@${snapshot.data![index - 1].fields.username}"),
                                        // Tambahkan widget lain di sini jika diperlukan
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          }));
                }
              }),
        ));
  }
}
