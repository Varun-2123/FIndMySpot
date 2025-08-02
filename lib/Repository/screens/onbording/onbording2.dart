import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/boarding/boarding.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Onbording2 extends StatefulWidget {
  const Onbording2({super.key});

  @override
  State<Onbording2> createState() => _Onbording2State();
}

class _Onbording2State extends State<Onbording2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 60.w),
              Image.asset("assets/images/Line.png"),
              SizedBox(width: 25.w),
              SizedBox(
                height: 420.h,
                width: 190.w,
                child: Stack(
                  children: [
                    Positioned(
                      left: 5.w,
                      top: 12.h,
                      child: Image.asset("assets/images/Light L.png"),
                    ),
                    Positioned(
                      top: 12.h,
                      right: 5.w,
                      child: Image.asset("assets/images/Light R.png"),
                    ),
                    Positioned(
                      bottom: 5.h,
                      left: 30.w,
                      child: Image.asset("assets/images/Car1.png"),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25.w),
              Image.asset("assets/images/Line.png"),
            ],
          ),
          SizedBox(height: 90.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(
                FontAwesomeIcons.bolt,
                size: 38,
                color: Appcolors.mainYellow,
              ),
              SizedBox(width: 20.w),
              Uihelper.customText(
                text: "Charging",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.bold,
                size: 23,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: Uihelper.customText(
              text: "Awesome 🧤experience car energy charge",
              color: Appcolors.mainBlack,
              fontWeight: FontWeight.w500,
              fontFamily: "Medium",
              size: 35,
            ),
          ),
          SizedBox(height: 90.h),
          Row(
            children: [
              SizedBox(width: 25.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Homescreen()),
                  );
                },
                child: Uihelper.greyButton(text: "Skip"),
              ),
              SizedBox(width: 15.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Boarding()),
                  );
                },
                child: Uihelper.blueButton(text: "Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
