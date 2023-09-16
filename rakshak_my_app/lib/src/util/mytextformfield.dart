import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode nextFocusNode;
  final String? Function(String?)? validator;
  final Icon prefixIcon;
  final String labelText;

  const EmailInputField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.labelText,
    this.validator,
    required this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Change to your desired subtext
      style: GoogleFonts.belgrano(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          fontWeight: FontWeight.normal,
          fontSize: 18),
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        labelText: labelText,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.black,
        border: OutlineInputBorder(
          // borderSide: const BorderSide(width: 15),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onEditingComplete: () => nextFocusNode.requestFocus(),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
