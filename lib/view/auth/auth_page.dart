import 'package:digifarmer/application.dart';
import 'package:digifarmer/view/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return const Application();
          } else {
            return const LoginOrRegister();
          }
        });
  }
}
