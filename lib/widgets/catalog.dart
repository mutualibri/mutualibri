import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/screens/login/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CatalogTemplate extends StatefulWidget {
  const CatalogTemplate({Key? key}) : super(key: key);

  @override
  _CatalogTemplateState createState() => _CatalogTemplateState();
}

class _CatalogTemplateState extends State<CatalogTemplate> {
  late TextEditingController _searchController;
  late Timer _debounce;
  late List<Book> _allBooks;
  late List<Book> _filteredBooks;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    _allBooks = [];
    _filteredBooks = [];
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    final request = context.read<CookieRequest>();
    String url = 'http://127.0.0.1:8000/book/json/';
    var response = await request.get(url);

    List<Book> listProduct = [];
    for (var d in response) {
      if (d != null) {
        listProduct.add(Book.fromJson(d));
      }
    }

    setState(() {
      _allBooks = listProduct;
      _filteredBooks = _allBooks; 
    });
  }

  List<Book> _filterBooks(String keyword) {
    return _allBooks
        .where((book) =>
            book.fields.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  void _onSearchChanged(String value) {
    if (_debounce.isActive) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _filteredBooks = _filterBooks(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text('Catalog'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 229, 173),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_allBooks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else if (_filteredBooks.isEmpty) {
      return const Center(
        child: Text(
          "Tidak ada data produk.",
          style: TextStyle(
            color: const Color.fromARGB(255, 221, 0, 0),
            fontSize: 20,
          ),
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.5,
        ),
        itemCount: _filteredBooks.length,
        itemBuilder: (_, index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(8.0),
          height: 800, // Adjust container height as needed
          width: 200, // Adjust container width as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "${_filteredBooks[index].fields.image}",
                    height: 150.0, // Adjust image height as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              HoverText(
                text: _limitSubstring(
                    "${_filteredBooks[index].fields.title}"),
                defaultColor: Colors.black,
                hoverColor: Colors.blue,
              ),
            ],
          ),
        ),
      );
    }
  }

  String _limitSubstring(String input) {
    List<String> parts = [];

    if (input.contains("(")) {
      parts = input.split("(");
    } else if (input.contains(":")) {
      parts = input.split(":");
    } else {
      parts.add(input);
    }

    return parts.first.trim();
  }

  void _logout(BuildContext context) async {
    final request = context.read<CookieRequest>();
    await request.logout('http://127.0.0.1:8000/auth/logout/');

    // Navigate to the login page after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final Color defaultColor;
  final Color hoverColor;

  const HoverText({
    required this.text,
    required this.defaultColor,
    required this.hoverColor,
    Key? key,
  }) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHover(true),
      onExit: (_) => _updateHover(false),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isHovered ? widget.hoverColor : widget.defaultColor,
        ),
      ),
    );
  }

  void _updateHover(bool hoverStatus) {
    if (isHovered != hoverStatus) {
      setState(() {
        isHovered = hoverStatus;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: CatalogTemplate(),
  ));
}
