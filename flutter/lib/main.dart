import 'package:flutter/material.dart';
import '../screens/landing_page.dart';
import '../screens/login_page.dart';
import '../screens/signup_page.dart';
import '../screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(isVisitor: false),  // Default HomePage without visitor
      },
    );
  }
}
