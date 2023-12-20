// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mutualibri/screens/quotes/quote_form.dart';
import 'package:mutualibri/widgets/drawer.dart';

class QuoteNull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "There's no quotes yet",
          style: TextStyle(
            color: Color(0xFFED8728),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        const Text(
          "Be the First to Add a Quote!",
          style: TextStyle(
            color: Color(0xFFED8728),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 241, 188, 74)),
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuoteForm(),
              ),
            );
          },
          child: const Text(
            "add your quote here!",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    )));
  }
}

void main() {
  runApp(MaterialApp(
    home: QuoteNull(),
  ));
}
