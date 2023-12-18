// ignore_for_file: library_private_types_in_public_api, unnecessary_string_interpolations

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/models/review.dart';
import 'package:mutualibri/screens/review/review_form.dart';
import 'package:mutualibri/widgets/drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewProductPage extends StatefulWidget {
  const ReviewProductPage({Key? key}) : super(key: key);

  @override
  _ReviewProductPageState createState() => _ReviewProductPageState();
}

class _ReviewProductPageState extends State<ReviewProductPage> {
  // String _sortOrder = 'asc';

  Future<List<Review>> fetchReview() async {
    final request = context.watch<CookieRequest>();
    String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/review/json/';

    var response = await request.get(url);

    List<Review> listReview = [];
    for (var d in response) {
      if (d != null) {
        listReview.add(Review.fromJson(d));
      }
    }

    // // Sorting based on _sortOrder
    // if (_sortOrder == 'desc') {
    //   listReview = listReview.reversed.toList(); // Reversing the list order
    // }

    return listReview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Page', style: TextStyle(color: Colors.black),),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      drawer: const DrawerClass(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Text(
                "You can add your own book review here!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 241, 188, 74)),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReviewFormPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Add review here!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
            // DropdownButton<String>(
            //   value: _sortBy,
            //   onChanged: (String? newValue) {
            //     setState(() {
            //       _sortBy = newValue!;
            //     });
            //   },
            //   items: <String>['id', 'asc', 'desc']
            //       .map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value == 'asc' || value == 'desc' ? value == 'asc' ? 'Oldest' : 'Recent' : 'ID'),
            //         );
            //       }).toList(),
            // ),
            Expanded(
              child: FutureBuilder(
                future: fetchReview(),
                builder: (context, AsyncSnapshot<List<Review>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.isEmpty) {
                    return const Column(
                      children: [
                        Text(
                          "There is no review yet...",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Colors.black),
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        const TextSpan(
                                          text: "@",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "${snapshot.data![index].fields.username}",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMd().format(snapshot
                                        .data![index].fields.dateAdded
                                        .toLocal()),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                color: Colors.black,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Title: ",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data![index].fields.title}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Rating: ",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data![index].fields.rating}/100",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Review: ",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${snapshot.data![index].fields.review}",
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
