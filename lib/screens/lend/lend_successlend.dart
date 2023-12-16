import 'package:flutter/material.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/screens/lend/lend_listlend.dart';
import 'package:mutualibri/widgets/catalog.dart';

import '../../constants.dart';

class SuccessPage extends StatefulWidget {
  final Book book;

  const SuccessPage({Key? key, required this.book}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150.0),
            Center(
              child: Text(
                widget.book.fields.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Center(
              child: Text(
                "Show this book number to the library admin to pick up your book!",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFED8728), // Border color
                  width: 3.0, // Border width, adjust as needed
                ),
                color: Colors.transparent, // Set fill color to transparent
              ),
              child: Center(
                child: Text(
                  widget.book.fields.number.toString(),
                  style: const TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              margin: EdgeInsets.zero, // Set margin to zero
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CatalogTemplate()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                ),
                child: const Text(
                  'Back to home',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: EdgeInsets.zero, // Set margin to zero
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LendListPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryLightColor,
                  elevation: 0,
                ),
                child: const Text(
                  'Go to my lend list',
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
    );
  }
}
