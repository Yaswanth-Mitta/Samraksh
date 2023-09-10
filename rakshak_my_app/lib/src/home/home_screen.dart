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
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(title: const Text("Home Screen"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("sign In as ${user.email!} "),
            
            ElevatedButton(onPressed: () =>FirebaseAuth.instance.signOut(), child: const Text("Sign Out")),
          ],
        ),
      ),
    );
  }
}