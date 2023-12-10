import 'package:flutter/material.dart';
import 'package:mutualibri/screens/menu.dart';
import 'package:mutualibri/widgets/catalog.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mutualibri/screens/login/login.dart';
import 'package:mutualibri/screens/welcome/welcome_screen.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mutualibri/constants.dart';

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
          title: 'Flutter Auth',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: Colors.white,
                  backgroundColor: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPrimaryLightColor,
                iconColor: kPrimaryColor,
                prefixIconColor: kPrimaryColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              )),
          home: const LoginPage(),
        ));
  }
}
