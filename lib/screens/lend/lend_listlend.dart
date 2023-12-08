import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/models/one_book.dart';
import 'package:mutualibri/screens/lend/lend_detailbook.dart';
import 'package:mutualibri/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LendListPage extends StatefulWidget {
  const LendListPage({Key? key}) : super(key: key);

  @override
  _LendListState createState() => _LendListState();
}

class _LendListState extends State<LendListPage> {
  Future<List<OneBook>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    String url = 'http://127.0.0.1:8000/json/';

    var response = await request.get(url);

    List<OneBook> list_product = [];
    for (var d in response) {
      if (d != null) {
        list_product.add(OneBook.fromJson(d));
        
      }
    }
    return list_product;
  }

  Future<void> deleteData(OneBook data) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final cookieRequest = context.read<CookieRequest>();
      String url = 'http://127.0.0.1:8000/delete-lend-flutter/';

      try {
        var response = await cookieRequest.post(url, jsonEncode(data));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LendListPage(),
          ),
        );
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: kPrimaryColor,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My Lend List',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/Logo.png',
                  height: 30.0,
                  width: 30.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          "Tidak ada data produk.",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookPage(
                                book: snapshot.data![index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                  "Start Date of lend this book : ${snapshot.data![index].fields.startDate.toLocal().toString().substring(0, 10)}"),
                              SizedBox(height: 10),
                              Text(
                                  "End Date of lend this book : ${snapshot.data![index].fields.endDate.toLocal().toString().substring(0, 10)}"),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  deleteData(snapshot.data![index]);
                                },
                                child: Text('Finish your lend'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
