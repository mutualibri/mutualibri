import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mutualibri/screens/login.dart';
import 'package:mutualibri/models/database_book.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutualibri'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SearchBar(onSearch: (String searchTerm) async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookCatalog(searchTerm: searchTerm),
                  ),
                );
              }),
              FutureBuilder(
                future: fetchAllBooks(),
                builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No books found.',
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            'Catalog',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ShopCard(snapshot.data![index]);
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Book>> fetchAllBooks() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/book/json/'));

    if (response.statusCode == 200) {
      return bookFromJson(response.body);
    } else {
      throw Exception('Failed to fetch all books');
    }
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  SearchBar({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0xFFFBB825),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books...',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Color(0xFFE09E45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () async {
              // Mendapatkan kata kunci pencarian dari TextField
              String searchTerm = ''; // Ganti dengan sesuai TextField

              // Memanggil fungsi pencarian
              await onSearch(searchTerm);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text(
              'Search',
              style: TextStyle(color: Color(0xFFFBB825)),
            ),
          ),
        ],
      ),
    );
  }
}

class ShopCard extends StatelessWidget {
  final Book book;

  const ShopCard(this.book, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content:
                    Text("Kamu telah menekan tombol ${book.fields.title}!")));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                book.fields.image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
              const Padding(padding: EdgeInsets.all(3)),
              Text(
                book.fields.title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookCatalog extends StatefulWidget {
  final String searchTerm;

  BookCatalog({required this.searchTerm});

  @override
  _BookCatalogState createState() => _BookCatalogState();
}

class _BookCatalogState extends State<BookCatalog> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    searchBooks(widget.searchTerm);
  }

  Future<void> searchBooks(String searchTerm) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/book/json/$searchTerm'));

    if (response.statusCode == 200) {
      final List<Book> booksData = bookFromJson(response.body);
      setState(() {
        books = booksData;
      });
    } else {
      throw Exception('Failed to search books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchTerm.isNotEmpty
            ? '${widget.searchTerm}'
            : 'Book Catalog'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ShopCard(books[index]);
        },
      ),
    );
  }
}
