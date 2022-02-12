import 'package:exam_app/signUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'logInPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const LoginPage(),
          'signup': (context) => const SignupPage(),
          'home': (context) => HomePage(),
        },
      ),
  );
}
