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
}
