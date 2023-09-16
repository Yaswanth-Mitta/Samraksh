// ignore_for_file: avoid_print, use_build_context_synchronously, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_my_app/main.dart';
import 'package:rakshak_my_app/src/auth/forgot_password.dart';
import 'package:rakshak_my_app/src/util/mypasswordformfield.dart';
import 'package:rakshak_my_app/src/util/mytextformfield.dart';
import 'package:rakshak_my_app/src/util/utils.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:rakshak_my_app/auth/login_firebase.dart';

import 'signup_screen.dart';
// import 'package:rakshak_app/src/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodePassword = FocusNode();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // const SizedBox(height: 150),
              // Text(
              //   "Welcome back",
              //   style: Theme.of(context).textTheme.headlineLarge,
              // ),
              // const SizedBox(height: 10),
              // Text(
              //   "Login to your account",
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              // Text(
              //   "Welcome ", // Change to your desired welcome text
              //   style: GoogleFonts.lugrasimo(
              //     textStyle: Theme.of(context).textTheme.titleMedium,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 30
              //   ),
              // ),
              const SizedBox(height: 40), // Adjust the spacing
              Image.asset(
                "assets/l1.png", // Replace with your app logo asset path
                // width: 400, // Adjust the width as needed
                height: 200, // Adjust the height as needed
              ),
              const SizedBox(height: 20), // Add some spacing
              const SizedBox(height: 10), // Add some spacing
              Text(
                "Login to your account", // Change to your desired subtext
                style: GoogleFonts.lugrasimo(
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              const SizedBox(height: 60),
              EmailInputField(
                controller: _controllerEmail,
                nextFocusNode: _focusNodePassword,
                labelText: "Email", // Provide the label text
                prefixIcon:
                    const Icon(Icons.person_outline), // Provide the prefix icon
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email .";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              PasswordInputField(
                controller: _controllerPassword,
                focusNode: _focusNodePassword,
                labelText: "Password", // Customize the label text
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password.";
                  }
                  // You can add more password validation logic here if needed
                  return null;
                },
              ),

              // const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()));
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      )),
                ],
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: signIn,
                    child: Text(
                      "Login",
                      style: GoogleFonts.aBeeZee(
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.black
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState?.reset();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const SignupScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    // print('Hellllllllllllllllllllll');
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      print("Invalid Form");
      return;
    }
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);

      print(e);
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
