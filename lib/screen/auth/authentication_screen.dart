import 'package:flutter/material.dart';
import 'package:techno_news/screen/auth/login_screen/login_screen.dart';
import 'package:techno_news/screen/auth/register_screen/register_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool showLogin = true;
  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen(
            onNavigationChange: () {
              setState(() {
                showLogin = false;
              });
            },
          )
        : RegisterScreen(
            onNavigationChange: () {
              setState(() {
                showLogin = true;
              });
            },
          );
  }
}
