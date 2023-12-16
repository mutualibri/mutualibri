import 'package:flutter/material.dart';
import 'package:mutualibri/screens/quotes/quote_form.dart';
import 'package:mutualibri/screens/quotes/quote_template.dart';
import 'package:mutualibri/widgets/drawer.dart';

class QuoteNull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerClass(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Be the First to Add a Quote',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFED8728), // Gunakan warna dari color palette
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement action when the button is pressed
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuoteForm()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color(0xFFFBB825)), // Gunakan warna dari color palette
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Add Your Quote Here!',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

void main() {
  runApp(MaterialApp(
    home: QuoteNull(),
  ));
}
