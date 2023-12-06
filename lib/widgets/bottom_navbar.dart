import 'package:flutter/material.dart';
import 'package:mutualibri/screens/review_page.dart';

void main() => runApp(const BottomNavigationBarExampleApp());

class BottomNavigationBarExampleApp extends StatelessWidget {
  const BottomNavigationBarExampleApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      // If Review is tapped, navigate to the ReviewPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('mutualibri'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Home',
              child: Icon(Icons.home),
            ),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Checkout',
              child: Icon(Icons.book),
            ),
            label: 'Checkout',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Review',
              child: Icon(Icons.reviews),
            ),
            label: 'Review',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Quotes',
              child: Icon(Icons.comment),
            ),
            label: 'Quotes',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Profile',
              child: Icon(Icons.person),
            ),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
