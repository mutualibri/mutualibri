// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(SearchBartesApp());

class SearchBartesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchBartes(title: 'Flutter Demo Home Page'),
    );
  }
}

class SearchBartes extends StatefulWidget {
  final String title;

  const SearchBartes({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _SearchBartesState createState() => _SearchBartesState();
}

class _SearchBartesState extends State<SearchBartes> {
  bool _searchBoolean = false;
  List<String> _searchIndexList = [];
  List<Book> list_product = [];

  @override
  void initState() {
    super.initState();
    fetchProduct().then((products) {
      setState(() {
        list_product = products;
      });
    });
  }

  Future<List<Book>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/book/json/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Product
    List<Book> list_product = [];
    for (var d in response.body) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }

  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          String searchLowerCase = s.toLowerCase(); // Convert search string to lowercase
          for (int i = 0; i < list_product.length; i++) {
            if ((list_product[i].title.toLowerCase()).contains(searchLowerCase)) {
              _searchIndexList.add(i.toString());
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
      itemCount: _searchIndexList.length,
      itemBuilder: (context, index) {
        int i = int.parse(_searchIndexList[index]);
        return Card(
          child: ListTile(
            title: Text(list_product[i].title),
          ),
        );
      },
    );
  }

  Widget _defaultListView() {
    return ListView.builder(
      itemCount: list_product.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(list_product[index].title),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !_searchBoolean ? Text(widget.title) : _searchTextField(),
        actions: !_searchBoolean
            ? [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _searchBoolean = true;
                      _searchIndexList = [];
                    });
                  },
                )
              ]
            : [
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                      });
                    })
              ],
      ),
      body: !_searchBoolean ? _defaultListView() : _searchListView(),
    );
  }
}
