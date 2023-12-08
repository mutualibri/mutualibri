import 'package:flutter/material.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/screens/lend/lend_setinput.dart';
import 'package:mutualibri/screens/menu.dart';

class BookPage extends StatelessWidget {
  final Book book;

  const BookPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text(
          'Detail Buku',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      book.fields.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: const Color(
                          0xFFFDE8C9), // Set the desired background color
                      padding: const EdgeInsets.all(20),
                      constraints: BoxConstraints(
                        maxWidth: 300.0, // Set the maximum width you desire
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 400,
                            width: double.infinity,
                            child: Image.network(
                              "${book.fields.image}",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Synopsis: \n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: book.fields.description,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Genres: \n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: book.fields.generes,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Author: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: book.fields.author,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'ISBN: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '${book.fields.isbn}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Publisher: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '${book.fields.publisher}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Published Date: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: book.fields.publishedDate,
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Page Count: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '${book.fields.pageCount}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Price: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '${book.fields.price}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Rating: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '${book.fields.rating}',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BorrowPage(book: book)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        elevation: 0,
                      ),
                      child: const Text(
                        'Lend this Book!',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
