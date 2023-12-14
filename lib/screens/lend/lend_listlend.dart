import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/models/database_book.dart';
import 'package:mutualibri/models/one_book.dart';
import 'package:mutualibri/models/quotes_model.dart';
import 'package:mutualibri/screens/quotes/quote_form.dart';
import 'package:mutualibri/widgets/bottom_navbar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LendListPage extends StatefulWidget {
  const LendListPage({Key? key}) : super(key: key);

  @override
  _LendListState createState() => _LendListState();
}

class _LendListState extends State<LendListPage> {
  Future<List<OneBook>> fetchProduct() async {
    final request = context.read<CookieRequest>();
    String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/json/';

    var response = await request.get(url);

    List<OneBook> listProduct = [];
    for (var d in response) {
      if (d != null) {
        OneBook onebook = OneBook.fromJson(d);
        listProduct.add(onebook);
      }
    }
    return listProduct;
  }

  Future<List<Book>> fetchBookList() async {
    final request = context.read<CookieRequest>();
    String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/book/json/';

    var response = await request.get(url);

    List<Book> listBook = [];
    for (var d in response) {
      if (d != null) {
        Book book = Book.fromJson(d);
        listBook.add(book);
      }
    }
    return listBook;
  }

  Future<void> deleteData(OneBook data) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      final cookieRequest = context.read<CookieRequest>();
      String url = 'https://mutualibri-a08-tk.pbp.cs.ui.ac.id/delete-lend-flutter/';

      try {
        var response = await cookieRequest.post(url, jsonEncode(data));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LendListPage(),
          ),
        );
      } catch (error) {
        print('Error: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: kPrimaryColor,
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'My Lend List',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/Logo.png',
                  height: 30.0,
                  width: 30.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: fetchProduct(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Column(
                      children: [
                        Text(
                          "Tidak ada data buku.",
                          style: TextStyle(
                            color: Color(0xff59A5D8),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return FutureBuilder(
                      future: fetchBookList(),
                      builder:
                          (context, AsyncSnapshot<List<Book>> bookSnapshot) {
                        if (bookSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (bookSnapshot.hasError) {
                          return Text('Error: ${bookSnapshot.error}');
                        } else if (!bookSnapshot.hasData ||
                            bookSnapshot.data!.isEmpty) {
                          return Text('No books available');
                        } else {
                          List<Book> listBook = bookSnapshot.data!;
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) => GestureDetector(
                              onTap: () {
                                // Handle tap on book item
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 250,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  listBook[snapshot.data[index]
                                                              .fields.book -
                                                          1]
                                                      .fields
                                                      .image,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Image.network(
                                              listBook[snapshot.data[index]
                                                          .fields.book -
                                                      1]
                                                  .fields
                                                  .image,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  // Image is fully loaded
                                                  return child;
                                                } else {
                                                  // Image is still loading, you can show a loading indicator or progress bar here
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
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
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                // Image failed to load, you can show an error message or a placeholder image here
                                                return Center(
                                                  child: SvgPicture.asset(
                                                      "assets/icons/ErrorImage.svg"),
                                                );
                                              },
                                              frameBuilder: (BuildContext
                                                      context,
                                                  Widget child,
                                                  int? frame,
                                                  bool wasSynchronouslyLoaded) {
                                                // After loading, you can perform additional actions if needed
                                                return child;
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Text(
                                                    listBook[snapshot
                                                                .data![index]
                                                                .fields
                                                                .book -
                                                            1]
                                                        .fields
                                                        .title,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  listBook[snapshot.data![index]
                                                              .fields.book -
                                                          1]
                                                      .fields
                                                      .author,
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                                Text(
                                                  "Start Date of lend this book : ${snapshot.data![index].fields.startDate.toLocal().toString().substring(0, 10)}",
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "End Date of lend this book : ${snapshot.data![index].fields.endDate.toLocal().toString().substring(0, 10)}",
                                                  style: const TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  isEndDateOverdue(snapshot
                                                          .data![index]
                                                          .fields
                                                          .endDate)
                                                      ? 'End Date is overdue!'
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: isEndDateOverdue(
                                                            snapshot
                                                                .data![index]
                                                                .fields
                                                                .endDate)
                                                        ? Colors.red
                                                        : Colors.green,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  splashFactory:
                                                      InkSplash.splashFactory,
                                                  child: Text(
                                                    'Review this book',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () {
                                                    // Navigate to QuoteForm
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const QuoteForm(),
                                                      ),
                                                    );
                                                  },
                                                  splashFactory:
                                                      InkSplash.splashFactory,
                                                  child: Text(
                                                    'Take quote from this book',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add functionality for the "Finish your lend" button
                                          deleteData(snapshot.data![index]);
                                        },
                                        child: Text('Finish your lend'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}

// Define a function to check if the end date is overdue
bool isEndDateOverdue(DateTime endDate) {
  DateTime currentDate = DateTime.now();
  return currentDate.isAfter(endDate);
}
