import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/Domain/Services/firebase/loggedIn.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/onbording/onbording1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<StatefulWidget> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  static const String field1 = "Login";
  @override
  void initState() {
    super.initState();
    checkerFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Appcolors.mainWhite,
        child: AvatarGlow(
          duration: Duration(milliseconds: 2800),
          glowCount: 3,
          glowColor: Appcolors.grey3,
          glowRadiusFactor: BorderSide.strokeAlignInside,
          child: Image.asset("assets/images/logo (1).png"),
        ),
      ),
    );
  }

  void checkerFunction() async {
    var pref = await SharedPreferences.getInstance();

    var isLoggedIn = pref.getBool(field1);

    if (isLoggedIn != null) {
      Timer(Duration(milliseconds: 2900), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Loggedin.nextRoute(isLoggedIn: isLoggedIn),
            ),
          );
        }
      });
    } else {
      Timer(Duration(milliseconds: 2900), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Onbording1()),
          );
        }
      });
    }
  }
}
