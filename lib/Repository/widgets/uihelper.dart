import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';

class Uihelper {
  static customText({
    required String text,
    required Color color,
    required FontWeight fontWeight,
    String? fontFamily,
    required double size,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontFamily: fontFamily ?? "Regular",
        fontSize: size,
      ),
    );
  }

  static greyButton({required String text}) {
    return Container(
      height: 85.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Appcolors.greyButton,
      ),
      child: Center(
        child: customText(
          text: text,
          color: Appcolors.mainBlack,
          fontWeight: FontWeight.w500,
          fontFamily: "Medium",
          size: 25,
        ),
      ),
    );
  }

  static blueButton({required String text}) {
    return Container(
      height: 85.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Appcolors.blueButton,
      ),
      child: Center(
        child: customText(
          text: text,
          color: Appcolors.mainWhite,
          fontWeight: FontWeight.w500,
          fontFamily: "Medium",
          size: 25,
        ),
      ),
    );
  }

  static vehiclesButton({
    required String text,
    required String icon,
    required String tapped,
  }) {
    var color1 = Appcolors.mainWhite;
    var color2 = Appcolors.mainWhite;
    if (tapped == "t") {
      color1 = Appcolors.mainYellow;
      color2 = Appcolors.mainBlack;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 155.h,
        width: 108.w,
        decoration: BoxDecoration(
          border: Border.all(color: color2, width: 2.sp),
          color: color1,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              SizedBox(height: 70.h, width: 70.w, child: Image.asset(icon)),
              SizedBox(height: 10.h),
              customText(
                text: text,
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w500,
                fontFamily: "Medium",
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
