import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/screens/review_list.dart';
import 'package:mutualibri/screens/welcome/welcome_screen.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    WelcomeScreen(), // EH KATALOG
    // lend di sini
    ReviewProductPage(),
      ReviewProductPage(),
    ReviewProductPage(),


    // TO DO!!!!!!!!!!!!!!!!
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: kPrimaryColor,
        // ),
        //backgroundColor: kPrimaryColor,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Lend',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment),
              label: 'Quote',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black, // Change the selected item color here
          unselectedItemColor: Colors.grey, // You can also set the unselected item color
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        //TO DO SAMMY
        child: ReviewProductPage(),
      ),
    );
  }
}

class LendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        //TO DO TATA
        child: ReviewProductPage(),

      ),
    );
  }
}

class ReviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ReviewProductPage(),
      ),
    );
  }
}

class QuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        //TO DO FARI
        child: ReviewProductPage(),
      ),
    );
  }
}
