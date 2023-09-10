import 'package:flutter/material.dart';
import 'package:rakshak_my_app/src/auth/login_screen.dart';
import 'package:rakshak_my_app/src/auth/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? const LoginScreen() : const SignupScreen();
}
