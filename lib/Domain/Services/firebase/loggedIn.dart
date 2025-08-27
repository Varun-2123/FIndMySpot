// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/screens/login/loginscreen.dart';
// import 'package:parking_app/Repository/screens/onbording/onbording1.dart';

class Loggedin {
  static Widget nextRoute({required bool isLoggedIn}) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data != null && isLoggedIn && isLoggedIn) {
          return Homescreen();
        }
        return Loginscreen();
      },
    );
  }
}
