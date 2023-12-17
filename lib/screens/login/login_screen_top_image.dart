// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Align the column's content at the center
      children: [
        const Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        const SizedBox(height: defaultPadding), // Adjusted spacing
        Container(
          height: 200.0, // Set a fixed height for the SVG container
          child: Image.asset("assets/images/Logo.png"),
        ),
        const SizedBox(height: defaultPadding), // Adjusted spacing
      ],
    );
  }
}
