import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/login/loginscreen.dart';
import 'package:parking_app/Repository/screens/registration/registrationscreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Boarding extends StatefulWidget {
  const Boarding({super.key});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 110.h),
          Row(
            children: [
              SizedBox(width: 12.w),
              Uihelper.customText(
                text: "Welcome to",
                color: Colors.black,
                fontWeight: FontWeight.w500,
                size: 26,
                fontFamily: "Medium",
              ),
              SizedBox(width: 5.w),
              Uihelper.customText(
                text: "FindMySpot",
                color: Appcolors.blueButton,
                fontWeight: FontWeight.w500,
                size: 35,
                fontFamily: "Bold",
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Uihelper.customText(
            text: "Because hunting for parking is so last year.",
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontFamily: "Medium",
            size: 14,
          ),
          SizedBox(height: 100.h),
          Image.asset("assets/images/parking_image.png", height: 300.h),
          SizedBox(height: 150.h),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginscreen()),
              );
            },
            child: Uihelper.loginButton(
              text: "Login",
              color: Appcolors.blueButton,
            ),
          ),
          SizedBox(height: 15.h),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Registrationscreen()),
              );
            },
            child: Uihelper.loginButton(text: "Sigh Up"),
          ),
        ],
      ),
    );
  }
}
