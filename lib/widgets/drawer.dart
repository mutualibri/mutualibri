import 'package:flutter/material.dart';
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
          const SizedBox(
            height: 30.0,
          ),
          // Adding clickable menu
          ListTile(
            leading: const Icon(Icons.collections),
            title: const Text('Our Collections'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CatalogTemplate(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('My LendList'),
            onTap: () {
              Navigator.pushReplacement(
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
              Navigator.pushReplacement(
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
              Navigator.pushReplacement(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
