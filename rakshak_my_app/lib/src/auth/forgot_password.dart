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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _controllerEmail,
                  // focusNode: _focusNodeEmail,
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
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return "Please enter email.";
                  //   } else if (!(value.contains('@') && value.contains('.'))) {
                  //     return "Invalid email";
                  //   }
                  //   return null;
                  // },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) => email!.isNotEmpty &&
                          !EmailValidator.validate(email.toString())
                      ? "Enter Valid Email "
                      : null,

                  // onEditingComplete: () => _focusNodePassword.requestFocus(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: verifyEmail,
                  child: const Text('Reset Password'),
                ),
              ],
            ),
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
