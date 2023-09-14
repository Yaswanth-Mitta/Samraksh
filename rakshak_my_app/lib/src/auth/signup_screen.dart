// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rakshak_my_app/main.dart';
import 'package:rakshak_my_app/src/util/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    super.dispose();
    _controllerAddress.dispose();
    _controllerConFirmPassword.dispose();
    _controllerEmail.dispose();
    _controllerGender.dispose();
    _controllerPassword.dispose();
    _controllerUsername.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 35),
              TextFormField(
                controller: _controllerUsername,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }

                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _controllerGender,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Gender",
                  prefixIcon: const Icon(Icons.male_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }

                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerAddress,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Address",
                  prefixIcon: const Icon(Icons.house_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your defalut Address.";
                  }

                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerEmail,
                focusNode: _focusNodeEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => email!.isNotEmpty &&
                        !EmailValidator.validate(email.toString())
                    ? "Enter Valid Email "
                    : null,
                onEditingComplete: () => _focusNodePassword.requestFocus(),
              ),
              const SizedBox(height: 10),
//
              // Password
//
              TextFormField(
                controller: _controllerPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) =>
                    password!.isNotEmpty && password.length < 6
                        ? "Password Must be atleast 6 Chars "
                        : null,
                onEditingComplete: () =>
                    _focusNodeConfirmPassword.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerConFirmPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodeConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) =>
                    password!.isNotEmpty && password != _controllerPassword.text
                        ? "Re-Entered Password is differnet from Password "
                        : null,
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // onPressed: () {
                    //   if (_formKey.currentState?.validate() ?? false) {

                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         width: 200,
                    //         backgroundColor:
                    //             Theme.of(context).colorScheme.secondary,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         behavior: SnackBarBehavior.floating,
                    //         content: const Text("Registered Successfully"),
                    //       ),
                    //     );

                    //     _formKey.currentState?.reset();

                    //     Navigator.pop(context);
                    //   }
                    // },
                    onPressed: signUp,
                    child: const Text("Register"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Login"),
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

  // final isValid = _formKey.currentState!.validate();
  // if (!isValid==false) {
  //   print("Invalid Form");
  //   return;
  //       final isValid = _formKey.currentState!.validate();
  // if (!isValid) {
  //   print("Invalid Form");
  //   return;
  // }
  // if (_formKey.currentState?.validate() ?? true) {
  //   return;
  // }
  // }
//   Future signUp() async {
//     showDialog(
//         context: context,
//         builder: (context) => const Center(
//               child: CircularProgressIndicator(),
//             ));
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: _controllerEmail.text.trim(),
//           password: _controllerPassword.text.trim());
//       await addUserDetails(
//         _controllerUsername.text.trim(),
//         _controllerGender.text.trim(),
//         _controllerAddress.text.trim(),
//         _controllerEmail.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       Utils.showSnackBar(e.message);
//     }

//     Navigator.of(context).popUntil((route) => route.isFirst);
//     // navigatorKey.currentState!.popUntil((route) => route.isFirst);
//   }

//   Future<void> addUserDetails(
//     String username, String gender, String address, String email) async {
//   try {
//     await FirebaseFirestore.instance.collection('users').add({
//       'user name': username,
//       'gender': gender,
//       'address': address,
//       'email': email,
//       'emergencymails' : []
//     });
//   } catch (e) {
//     print('Error adding user details: $e');
//   }
// }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'user name': _controllerUsername.text.trim(),
        'gender': _controllerGender.text.trim(),
        'address': _controllerAddress.text.trim(),
        'email': _controllerEmail.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    Navigator.of(context).popUntil((route) => route.isFirst);
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> addUserDetails(
      String username, String gender, String address, String email) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'user name': username,
        'gender': gender,
        'address': address,
        'email': email,
      });
    } catch (e) {
      print('Error adding user details: $e');
    }
  }
}
