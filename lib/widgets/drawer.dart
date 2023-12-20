import 'package:flutter/material.dart';
import 'package:mutualibri/constants.dart';
import 'package:mutualibri/screens/lend/lend_listlend.dart';
import 'package:mutualibri/screens/login/login.dart';
import 'package:mutualibri/screens/quotes/quote_template.dart';
import 'package:mutualibri/screens/review/review_list.dart';
import 'package:mutualibri/widgets/catalog.dart';

class DrawerClass extends StatelessWidget {
  const DrawerClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              children: [
                Text(
                  'Mutualibri',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Borrow your books easily through this application!",
                  style: TextStyle(
                    fontSize: 15.0, // Ukuran font 15
                    color: Colors.white, // Warna putih
                    fontWeight: FontWeight.normal, // Weight biasa
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Adding clickable menu
          ListTile(
            leading: const Icon(Icons.collections),
            title: const Text('Our Collections'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CatalogTemplate(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('My Lend List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LendListPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
            title: const Text('Reviews of Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReviewProductPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.format_quote),
            title: const Text('Quotes of Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuotePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text("Have you finished exploring?"),
                  actions: [
                    TextButton(
                      child: const Text('Not yet!'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Yes, I have'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
