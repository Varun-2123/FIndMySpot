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
          SizedBox(height: 90.h),
          Row(
            children: [
              SizedBox(width: 40.w),

              Uihelper.customText(
                text: "FindMySpot",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.bold,
                size: 48,
                fontFamily: "Bold",
              ),
            ],
          ),

          Uihelper.customText(
            text: "Because hunting for parking is so last year.",
            color: Appcolors.grey5,
            fontWeight: FontWeight.normal,
            fontFamily: "Medium",
            size: 14,
          ),
          SizedBox(height: 110.h),
          Image.asset(
            "assets/images/parking_image2.png",
            height: 300.h,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 120.h),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Loginscreen()),
              );
            },
            child: Uihelper.loginButton(
              text: "Login",
              color: Appcolors.mainYellow,
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
            child: Uihelper.loginButton(text: "Sign up"),
          ),
        ],
      ),
    );
  }
}
