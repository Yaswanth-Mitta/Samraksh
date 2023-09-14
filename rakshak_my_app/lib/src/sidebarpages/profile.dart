import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_my_app/src/util/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String userGender = '';
  String userAddress = '';
  String userEmail = '';
  String userId = '';
  bool isDataRead = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCurrentUserDetails();
  }

  Future<void> fetchCurrentUserDetails() async {
    try {
      // if (!isDataRead) {
      //   return;
      // }
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userId = user.uid;
        // isDataRead = false; // Initialize the flag to false

        // Use the user's UID to fetch their document from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists && !isDataRead) {
          // Access and use the user's data and update the state
          setState(() {
            userName = userDoc['user name'];
            userGender = userDoc['gender'];
            userAddress = userDoc['address'];
            userEmail = userDoc['email'];
            isDataRead =
                true; // Set the flag to true after the data has been read once
          });
        } else {
          return; // Exit the function early if the data has already been read
        }
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error fetching current user data: $e');
    } finally {
      setState(() {
        isLoading = false; // Ensure isLoading is set to false in all cases
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: isLoading
            ? const CircularProgressIndicator() // Display a loading indicator while data is being fetched
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userEmail,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userGender,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Address : $userAddress",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      // Handle sign-out here
                      FirebaseAuth.instance.signOut();
                      Utils.showSnackBar(
                          "Succesfully logged out from $userName");
                    },
                    child: const Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
