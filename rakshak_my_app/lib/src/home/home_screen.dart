// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      
      backgroundColor: Colors.deepPurpleAccent.shade100.withGreen(150),
      // appBar: AppBar(title: const Text("Home Screen"),),
      body: Center(
        child: SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
          ),
          onPressed: () {},
          child: const Text(
        "Alert",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
          ),
        ),
      ),
      )
    );
  }
}



