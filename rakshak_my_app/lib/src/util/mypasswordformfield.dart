import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String labelText; // Add label text as a parameter
  final String? Function(String?)? validator;

  const PasswordInputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.labelText, // Specify label text as required
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.belgrano(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          fontWeight: FontWeight.normal,
          fontSize: 20
          ),
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscurePassword,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: widget.labelText, // Use the provided label text
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.black26,
        labelStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: const Icon(
          Icons.password_outlined,
          color: Colors.black,
        ),

        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
          icon: _obscurePassword
              ? const Icon(
                  Icons.visibility_outlined,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.visibility_off_outlined,
                  color: Colors.redAccent,
                ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3),
          borderRadius: BorderRadius.circular(10),
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
