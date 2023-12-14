import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/menu.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/screens/lend/lend_detailbook.dart';
import 'package:mutualibri/screens/quotes/quote_template.dart';
import 'package:mutualibri/widgets/bottom_navbar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CatalogTemplate extends StatefulWidget {
  const CatalogTemplate({Key? key}) : super(key: key);

  @override
  _CatalogTemplateState createState() => _CatalogTemplateState();
}

class _CatalogTemplateState extends State<CatalogTemplate> {
  Future<List<Book>> fetchProduct() async {
    final request = context.watch<CookieRequest>();
    String url = 'http://127.0.0.1:8000/book/json/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Product
    List<Book> list_product = [];
    for (var d in response) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }

  String _limitSubstring(String input) {
    List<String> parts = [];

    // Memeriksa karakter "(" dan ":" untuk memotong string
    if (input.contains("(")) {
      parts = input.split("(");
    } else if (input.contains(":")) {
      parts = input.split(":");
    } else {
      parts.add(input);
    }

    return parts.first
        .trim(); // Mengambil bagian pertama setelah melakukan split dan menghapus spasi di awal dan akhir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text(
          'Our Book Collections',
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
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
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
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah elemen dalam satu baris
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.5,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(8.0),
                  height: 800, // Atur tinggi container sesuai kebutuhan
                  width: 200, // Atur lebar container sesuai kebutuhan
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookPage(book: snapshot.data![index],),
                                  ));
                            },
                            child: Image.network(
                              "${snapshot.data![index].fields.image}",
                              height: 150.0, // Sesuaikan tinggi gambar
                              width: double
                                  .infinity, // Lebar gambar mengikuti container
                              fit: BoxFit.cover, // Atur sesuai kebutuhan
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  // Image is fully loaded
                                  return child;
                                } else {
                                  // Image is still loading, you can show a loading indicator or progress bar here
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                // Image failed to load, you can show an error message or a placeholder image here
                                return Center(
                                  child: SvgPicture.asset(
                                      "assets/icons/ErrorImage.svg"),
                                );
                              },
                              frameBuilder: (BuildContext context, Widget child,
                                  int? frame, bool wasSynchronouslyLoaded) {
                                // After loading, you can perform additional actions if needed
                                return child;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      HoverText(
                        text: _limitSubstring(
                            "${snapshot.data![index].fields.title}"),
                        defaultColor: Colors.black,
                        hoverColor: Colors.blue,
                        book: snapshot
                            .data![index], // Pass book data to HoverText
                      ),
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class HoverText extends StatefulWidget {
  final String text;
  final Color defaultColor;
  final Color hoverColor;
  final Book book; // Added parameter for book data

  const HoverText({
    required this.text,
    required this.defaultColor,
    required this.hoverColor,
    required this.book,
    Key? key,
  }) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onEnter: (_) => _updateHover(true),
      // onExit: (_) => _updateHover(false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookPage(book: widget.book),
          ),
        );
      },
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
