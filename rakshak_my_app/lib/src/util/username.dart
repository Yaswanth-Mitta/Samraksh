// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsernameInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode nextFocusNode;
  final String? Function(String?)? validator;
  final String labeltext;
  final Icon icon;

  const UsernameInputField({
    Key? key,
    required this.controller,
    required this.nextFocusNode,
    this.validator,
    required this.labeltext,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.lugrasimo(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          fontWeight: FontWeight.normal,
          fontSize: 20
          ),
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        labelText: labeltext,
        // prefixIcon: const Icon(
        //   Icons.person_outline,
        //   color: Colors.black,
        // ),
        prefixIcon: icon,
        prefixIconColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black, // Change border color to black
          ),
        ),
      ),
      validator: validator,
      onEditingComplete: () => nextFocusNode.requestFocus(),
    );
  }
}
