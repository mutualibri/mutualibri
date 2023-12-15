// import 'package:flutter/material.dart';
// import 'package:mutualibri/screens/login/login.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart'; // Pastikan import library yang dibutuhkan

// class RegisterPage extends StatefulWidget {
//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();

//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 12.0),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//               ),
//               obscureText: true,
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 String username = _usernameController.text;
//                 String password = _passwordController.text;
//                 String confirmPassword = _confirmPasswordController.text;

//                 if (password != confirmPassword) {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Error'),
//                       content: Text('Password dan Confirm Password harus sama.'),
//                       actions: [
//                         TextButton(
//                           child: Text('OK'),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                   return;
//                 }

//                 final response = await request.register(
//                   "http://127.0.0.1:8000/auth/register/",
//                   {
//                     'username': username,
//                     'password1': password,
//                     'password2': confirmPassword,
//                   },
//                 );

//                 if (response['success']) {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                   );
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AlertDialog(
//                       title: Text('Error'),
//                       content: Text(response['message']),
//                       actions: [
//                         TextButton(
//                           child: Text('OK'),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//               child: const Text(
//                 'Register',
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Add your widget for "Already have an account?" here
//           ],
//         ),
//       ),
//     );
//   }
// }
