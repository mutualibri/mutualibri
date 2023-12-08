import 'package:flutter/material.dart';
import 'package:mutualibri/screens/login.dart'; 
import 'package:mutualibri/screens/register.dart'; 

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue, // Sesuaikan dengan warna latar belakang yang diinginkan
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

