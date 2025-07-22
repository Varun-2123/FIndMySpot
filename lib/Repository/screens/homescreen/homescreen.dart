import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var name = "John";
  var vehicles = [
    {"icon": FontAwesomeIcons.carSide, "text": "Car"},
    {"icon": FontAwesomeIcons.motorcycle, "text": "Bike"},
    {"icons": FontAwesomeIcons.bus, "text": "Bus"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              Image.asset(
                "assets/images/Profile.png",
                height: 60.h,
                width: 60.w,
              ),
              SizedBox(width: 220.w),
              Icon(FontAwesomeIcons.locationDot, size: 38.sp),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              SizedBox(width: 25.w),
              Uihelper.customText(
                text: "Hello, $name",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w500,
                fontFamily: "Medium",
                size: 22,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 25.w),
              Uihelper.customText(
                text: "Made easly",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w500,
                fontFamily: "Medium",
                size: 42,
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 25.w),
              Uihelper.customText(
                text: "Parking",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w500,
                fontFamily: "Bold",
                size: 45,
              ),
            ],
          ),
          // ListView.builder(
          //   itemBuilder: (context, index) {
          //     return Container(
          //       height: 125.h,
          //       width: 108.w,
          //       decoration: BoxDecoration(
          //         color: Appcolors.mainYellow,
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //       child: Center(
          //         child: Column(
          //           children: [
          //             SizedBox(height: 10.h),
          //             Icon(vehicles[index]["icon"], size: 50.sp),
          //             SizedBox(height: 10.h),
          //             customText(
          //               text: text,
          //               color: Appcolors.mainBlack,
          //               fontWeight: FontWeight.w500,
          //               fontFamily: "Medium",
          //               size: 25,
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
