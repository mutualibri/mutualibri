import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/screens/quotes/quote_template.dart';
import 'package:mutualibri/widgets/bottom_navbar.dart';
import 'package:mutualibri/widgets/catalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class QuoteForm extends StatefulWidget {
  // final List<Book> book;
  const QuoteForm({Key? key}) : super(key: key);

  @override
  State<QuoteForm> createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  final _formKey = GlobalKey<FormState>();
  String _bookName = "";
  String _quotes = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // print(widget.book.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text(
          'Your new qoutesbook',
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
                MaterialPageRoute(builder: (context) => CatalogTemplate()),
              );
            },
          ),
        ],
      ),
      drawer: DrawerClass(),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: DropdownButtonFormField<String>(
                //     value: _bookName,
                //     icon: const Icon(Icons.arrow_downward),
                //     iconSize: 24,
                //     elevation: 16,
                //     style: const TextStyle(color: Colors.deepPurple),
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _bookName = newValue!;
                //       });
                //     },
                //     items: widget.book.map((Book book) {
                //       return DropdownMenuItem<String>(
                //         value: book.fields
                //             .title, // Assuming Book has a 'title' property
                //         child: Text(book.fields.title),
                //       );
                //     }).toList(),
                //     decoration: InputDecoration(
                //       labelText: 'Judul Buku',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Judul Buku",
                      labelText: "Judul Buku",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _bookName = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Nama tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Quote",
                      labelText: "Quote",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _quotes = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Deskripsi tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 241, 188, 74)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Kirim ke Django dan tunggu respons
                          final response = await request.postJson(
                              "https://mutualibri-a08-tk.pbp.cs.ui.ac.id/quote/create-flutter/",
                              jsonEncode(<String, String>{
                                'book_name': _bookName,
                                'quotes': _quotes,
                                // TODO: Sesuaikan field data sesuai dengan aplikasimu
                              }));
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Quote baru berhasil disimpan!"),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuotePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Terdapat kesalahan, silakan coba lagi."),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Save Quote",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
