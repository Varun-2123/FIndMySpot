import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Onbording1 extends StatefulWidget {
  const Onbording1({super.key});
  @override
  State<StatefulWidget> createState() => Onbording1State();
}

class Onbording1State extends State<Onbording1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120.h),
          Stack(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 200.h,
                  backgroundColor: Appcolors.grey1,
                ),
              ),
              Positioned(
                top: 80.h,
                left: 82.w,
                child: CircleAvatar(
                  radius: 120.h,
                  backgroundColor: Appcolors.mainWhite,
                ),
              ),
              Positioned(
                bottom: 100.h,
                child: Image.asset("assets/images/Car.png"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(FontAwesomeIcons.car, size: 42, color: Appcolors.mainGreen),
              SizedBox(width: 20.w),
              Uihelper.customText(
                text: "Car Parking",
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
              text: "You can feel best performance on your drive 💪",
              color: Appcolors.mainBlack,
              fontWeight: FontWeight.w500,
              fontFamily: "Medium",
              size: 37,
            ),
          ),
        ],
      ),
    );
  }
}
