// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../util/utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerEmail = TextEditingController();
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  //     appBar: AppBar(
  //       title: const Text('Forgot Password'),
  //     ),
  //     body: Form(
  //       key: _formKey,
  //       child: Center(
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               TextFormField(
  //                 controller: _controllerEmail,
  //                 // focusNode: _focusNodeEmail,
  //                 keyboardType: TextInputType.emailAddress,
  //                 decoration: InputDecoration(
  //                   labelText: "Email",
  //                   prefixIcon: const Icon(Icons.email_outlined),
  //                   border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                 ),
  //                 // validator: (String? value) {
  //                 //   if (value == null || value.isEmpty) {
  //                 //     return "Please enter email.";
  //                 //   } else if (!(value.contains('@') && value.contains('.'))) {
  //                 //     return "Invalid email";
  //                 //   }
  //                 //   return null;
  //                 // },
  //                 autovalidateMode: AutovalidateMode.onUserInteraction,
  //                 validator: (email) => email!.isNotEmpty &&
  //                         !EmailValidator.validate(email.toString())
  //                     ? "Enter Valid Email "
  //                     : null,

  //                 // onEditingComplete: () => _focusNodePassword.requestFocus(),
  //               ),
  //               const SizedBox(height: 20),
  //               ElevatedButton(
  //                 onPressed: verifyEmail,
  //                 child: const Text('Reset Password'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            print("called");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const MainPage()));
          },
        ),
        title: const Text("Reset Password"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Reset pasword",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Please check your email for a reset Password link.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () => verifyEmail(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email address.";
                  }

                  if (!value.contains("@")) {
                    return "Please enter a valid email address.";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: verifyEmail,
                child: const Text("Reset password"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future verifyEmail() async {
    // if(_formKey.isV)
    // if (_formKey.currentState!.validate() == false) return;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text.trim());
      Utils.showSnackBar("Check Your Registered Email");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
