// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/screens/review/review_list.dart';
import 'package:mutualibri/widgets/drawer.dart';
import 'package:mutualibri/widgets/catalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
  const ReviewFormPage({Key? key}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  int _rating = 0;
  String _review = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFfbb825),
        title: const Text(
          'Form Add Review',
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
                MaterialPageRoute(builder: (context) => const CatalogTemplate()),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerClass(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Title",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Title must not be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Review",
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ), 
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _review = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Review must not be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Rating (0-100)",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _rating = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Rating must not be empty!";
                    }
                    int? rating = int.tryParse(value);
                    if (rating == null || rating < 0 || rating > 100) {
                      return "Rating must be a positive integer between 0 and 100!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 16),
                                Text("Saving..."),
                              ],
                            ),
                          ),
                        );

                        final response = await request.postJson(
                          "https://sabrina-atha-mutualibriourproject.stndar.dev/review/create-flutter/",
                          jsonEncode(<String, String>{
                            'title': _title,
                            'rating': _rating.toString(),
                            'review': _review,
                          }),
                        );

                        ScaffoldMessenger.of(context).removeCurrentSnackBar();

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Review is successfully added!"),
                            ),
                          );

                          // Pop the current route (ReviewFormPage) from the stack
                          Navigator.pop(context);
                          
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReviewProductPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "There is an error when adding review, please try again!",
                              ),
                            ),
                          );
                        }
                      }
                      _formKey.currentState!.reset();
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            "Save",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
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
