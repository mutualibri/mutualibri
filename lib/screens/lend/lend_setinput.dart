import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mutualibri/screens/menu.dart';
import 'package:mutualibri/screens/lend/lend_successlend.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BorrowPage extends StatefulWidget {
  final Book book;

  const BorrowPage({Key? key, required this.book}) : super(key: key);

  @override
  _BorrowPageState createState() => _BorrowPageState();
}

class _BorrowPageState extends State<BorrowPage> {
  final _formKey = GlobalKey<FormState>();
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    endDate = DateTime.now().add(const Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text(
          'LendBook',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          // Add your image or icon to the right side of the AppBar
          IconButton(
            icon: Image.asset(
              'assets/images/Logo.png', // Replace with your image asset
              height: 50, // Set the desired height
              width: 50, // Set the desired width
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
              // Add any action you want when the image/icon is pressed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.book.fields.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.network(
                  "${widget.book.fields.image}",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is fully loaded
                      return child;
                    } else {
                      // Image is still loading, you can show a loading indicator or progress bar here
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // Image failed to load, you can show an error message or a placeholder image here
                    return Center(
                      child: SvgPicture.asset("assets/icons/ErrorImage.svg"),
                    );
                  },
                  frameBuilder: (BuildContext context, Widget child, int? frame,
                      bool wasSynchronouslyLoaded) {
                    // After loading, you can perform additional actions if needed
                    return child;
                  },
                ),
              ),
              const SizedBox(height: 10.0),
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
                      text: widget.book.fields.description,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: ' \nNotes! \n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    TextSpan(
                      text:'Automatically set for 7 days.',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFBB825)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date of lend this book : ${startDate.toString().substring(0, 10)}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'End Date of lend this book : ${endDate.toString().substring(0, 10)}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://mutualibri-a08-tk.pbp.cs.ui.ac.id/create-lend-flutter/",
                          jsonEncode(<String, String>{
                            'book': widget.book.fields.number.toString(),
                            'startDate': startDate.toString(),
                            'endDate': endDate.toString(),
                            'number': widget.book.fields.number.toString(),
                          }),
                        );
                        if (response != null &&
                            response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Your new book lend has been successfully saved!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SuccessPage(book: widget.book)),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("There was an error, please try again."),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Lend Now!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
