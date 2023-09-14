import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/utils.dart';

class AddEmergencyEmailsScreen extends StatefulWidget {
  const AddEmergencyEmailsScreen({Key? key}) : super(key: key);

  @override
  State<AddEmergencyEmailsScreen> createState() =>
      _AddEmergencyEmailsScreenState();
}

class _AddEmergencyEmailsScreenState extends State<AddEmergencyEmailsScreen> {
  final List<String> _emails = [];
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the email data from Firestore when the screen is initially built
    fetchEmails();
  }

  Future<void> fetchEmails() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Fetch the email data from the 'emergencyEmails' collection
      final emailDoc = await FirebaseFirestore.instance
          .collection('emergencyEmails')
          .doc(userId)
          .get();

      if (emailDoc.exists) {
        final emailData = emailDoc.data();
        if (emailData != null && emailData['emails'] != null) {
          final List<dynamic> emailList = emailData['emails'];
          setState(() {
            _emails.addAll(emailList.map((e) => e.toString()));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNodeEmail = FocusNode();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controllerEmail,
              focusNode: focusNodeEmail,
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
              // onEditingComplete: () => focusNodePassword.requestFocus(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: addEmail,
              child: const Text("Add Email"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _emails.length,
                itemBuilder: (context, index) {
                  final email = _emails[index];

                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      await removeEmail(email);
                      setState(() {
                        _emails.remove(email);
                      });
                    },
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        title: Text(
                          email,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                        // trailing: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future addEmail() async {
    final email = _controllerEmail.text.trim();

    if (email.isEmpty) {
      return;
    }
    if (!EmailValidator.validate(email)) {
      Utils.showSnackBar("Enter Valid Email Address");
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Add the email to the 'emergencyEmails' collection
      await FirebaseFirestore.instance
          .collection('emergencyEmails')
          .doc(userId)
          .set(
              {
            'emails': FieldValue.arrayUnion([email]),
          },
              SetOptions(
                  merge:
                      true)); // Merge the data if the document already exists

      _emails.add(email);
      _controllerEmail.clear();

      setState(() {});
    }
  }

  Future removeEmail(String email) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;

      // Remove the email from the 'emergencyEmails' collection
      await FirebaseFirestore.instance
          .collection('emergencyEmails')
          .doc(userId)
          .update({
        'emails': FieldValue.arrayRemove([email]),
      });
    }
  }
}
