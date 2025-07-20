import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/onbording/onbording1.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});
  @override
  State<StatefulWidget> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2900), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onbording1()),
        );
      }
    });
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
}
