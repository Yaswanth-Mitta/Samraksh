// // ignore_for_file: unused_import

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(

//       backgroundColor: Colors.deepPurpleAccent.shade100.withGreen(150),
//       // appBar: AppBar(title: const Text("Home Screen"),),
//       body: Center(
//         child: SizedBox(
//         width: 200,
//         height: 50,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//           ),
//           onPressed: () {},
//           child: const Text(
//         "Alert",
//         style: TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//           ),
//         ),
//       ),
//       )
//     );
//   }
// }

// import 'dart:convert';
// import 'dart:io';

// ignore_for_file: avoid_print, unused_local_variable

// import 'dart:html';

import 'package:emailjs/emailjs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../util/utils.dart';
// import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// {{latitude}},{{longitude}}
// template_6tjkn5i

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Variables to store the data from Firestore
  Map<String, dynamic> userData = {};
  List<dynamic> emergencyEmails = [];
  late double latt;
  late double long;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    final user = _auth.currentUser;

    if (user != null) {
      // Fetch user data from the "users" collection
      final usersQuerySnapshot = await _firestore
          .collection('users')
          .doc(user.uid) // Assuming user ID is the document ID
          .get();

      userData = usersQuerySnapshot.data() as Map<String, dynamic>;

      // Fetch emergency email data from the "emergencyemails" collection
      final emergencyEmailsQuerySnapshot = await _firestore
          .collection("emergencyEmails")
          .doc(user.uid) // Assuming user ID is the document ID
          .get();

      if (emergencyEmailsQuerySnapshot.exists) {
        // The document exists, so we can retrieve the list of emergency emails
        emergencyEmails =
            emergencyEmailsQuerySnapshot['emails'] as List<dynamic>;
      } else {
        // The document does not exist or there are no emails, handle accordingly
        emergencyEmails = [];
      }

      // Update the UI
      setState(() {});
    }
  }

  Future<void> sendEmail(
      {required String name,
      required List<dynamic> emails,
      required String message}) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   Utils.showSnackBar("user Location Disabled");
    // }
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      // if(permission == LocationPermission.denied){

      // }
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) {
        // Get the latitude and longitude
        latt = position.latitude;
        long = position.longitude;
      });
    } catch (e) {
      print(e.toString());
      Utils.showSnackBar(e.toString());
    }

    try {
      await EmailJS.send(
        'service_8kxfswe', // Replace with your service ID
        'template_6tjkn5i', // Replace with your template ID
        {
          'from_name': name,
          'user_email': userData['email'],
          'to_email': emails,
          'latitude': latt.toString(),
          'longitude': long.toString()
        },
        const Options(
          publicKey: 'bYbVtyqCG1D2owsR_', // Replace with your public key
          privateKey: 'QiIJMprPv5uksIUUQw3kc', // Replace with your private key
        ),
      );
      print('Email sent successfully');
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        print('ERROR... ${error.status}: ${error.text}');
      }
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "User Data:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Name: ${userData['user name']}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Email: ${userData['email']}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Gender: ${userData['gender']}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Address: ${userData['address']}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Emergency Emails:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            for (var email in emergencyEmails)
              Text(
                "Email Address: $email",
                style: const TextStyle(fontSize: 16),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                sendEmail(
                    emails: emergencyEmails,
                    name: userData['user name'],
                    message: 'HLO');
              },
              child: const Text(
                "Alert",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emailjs/emailjs.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Variables to store the data from Firestore
//   Map<String, dynamic> userData = {};
//   List<String> emergencyEmails = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirestore();
//   }

//   Future<void> fetchDataFromFirestore() async {
//     final user = _auth.currentUser;

//     if (user != null) {
//       // Fetch user data from the "users" collection
//       final usersQuerySnapshot = await _firestore
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       userData = usersQuerySnapshot.data() as Map<String, dynamic>;

//       // Fetch emergency email data from the "emergencyemails" collection
//       final emergencyEmailsQuerySnapshot = await _firestore
//           .collection('emergencyemails')
//           .doc(user.uid)
//           .get();

//       if (emergencyEmailsQuerySnapshot.exists) {
//         // The document exists, so we can retrieve the list of emergency emails
//         emergencyEmails =
//             List<String>.from(emergencyEmailsQuerySnapshot['emails']);
//       } else {
//         // The document does not exist or there are no emails
//         emergencyEmails = [];
//       }

//       // Update the UI
//       setState(() {});
//     }
//   }

//   // Function to send emails
//   Future<void> sendEmails(List<String> emailAddresses) async {
//     final EmailJS emailJs = EmailJS(
//       // host: "your.smtp.server.com", // Replace with your SMTP server host
//       // port: 465, // Replace with your SMTP server port
//       // isLogEnabled: true, // Enable logging for debugging
//     );

//     final user = _auth.currentUser;

//     if (user != null) {
//       const senderEmail = "your_email@gmail.com"; // Replace with your sender email
//       const senderPassword = "your_password"; // Replace with your sender password

//       try {
//         await emailJs.send(
//           EmailMessage(
//             from: senderEmail,
//             password: senderPassword,
//             bcc: emailAddresses,
//             subject: "Emergency Alert",
//             text: "This is an emergency alert message.",
//           ),
//         );

//         print("Emails sent successfully.");
//       } catch (e) {
//         print("Error sending emails: $e");
//         // Handle the error and show an error message to the user
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Home Screen")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "User Data:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "Name: ${userData['user name']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Email: ${userData['email']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Gender: ${userData['gender']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             Text(
//               "Address: ${userData['address']}",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Emergency Emails:",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             for (var email in emergencyEmails)
//               Text(
//                 "Email Address: $email",
//                 style: const TextStyle(fontSize: 16),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => sendEmails(emergencyEmails),
//               child: const Text("Send Emergency Emails"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
