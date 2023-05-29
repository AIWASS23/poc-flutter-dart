import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zap_zap/auth/auth_page.dart';
import 'package:zap_zap/chat_page.dart';

@immutable
class MainPage extends StatelessWidget {
  String email;
  MainPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ChatPage();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
