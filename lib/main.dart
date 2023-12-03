import 'package:flutter/material.dart';
import 'package:mutualibri/screens/login.dart';
import 'package:mutualibri/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mutualibri/screens/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Mutualibri',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutualibri'),
        actions: [
          SearchBar(), // Tambahkan SearchBar di bagian atas halaman
        ],
      ),
      body: Column(
        children: [
          // Tambahkan konten utama di bawah SearchBar
          // ...
        ],
      ),
    );
  }
}
