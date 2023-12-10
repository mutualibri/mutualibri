import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
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
        title: const Text('Daftar Buku'),
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
                          child: Image.network(
                            "${snapshot.data![index].fields.image}",
                            height: 150.0, // Sesuaikan tinggi gambar
                            width: double
                                .infinity, // Lebar gambar mengikuti container
                            fit: BoxFit.cover, // Atur sesuai kebutuhan
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      HoverText(
                        text: _limitSubstring(
                            "${snapshot.data![index].fields.title}"),
                        defaultColor: Colors.black,
                        hoverColor: Colors.blue,
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
