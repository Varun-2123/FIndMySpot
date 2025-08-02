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
    {
      "icon": "assets/images/car_icon.png",
      "text": "Car",
      "img": "assets/images/Car1.png",
      "tapped": "t",
    },
    {
      "icon": "assets/images/bike_icon.png",
      "text": "Bike",
      "img": "assets/images/bike1.png",
      "tapped": "f",
    },
    {
      "icon": "assets/images/bus_icon.png",
      "text": "Bus",
      "img": "assets/images/bus.png",
      "tapped": "f",
    },
  ];
  var defaultImg = "assets/images/Car1.png";
  var defaultVeh = "Car";

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
          SizedBox(height: 30.h),
          SizedBox(
            height: 175.h,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    defaultImg = vehicles[index]["img"].toString();
                    setState(() {
                      for (int i = 0; i < vehicles.length; i++) {
                        vehicles[i]["tapped"] = "f";
                      }
                      vehicles[index]["tapped"] = "t";
                      defaultVeh = vehicles[index]["text"].toString();
                    });
                  },
                  child: Uihelper.vehiclesButton(
                    text: vehicles[index]["text"].toString(),
                    icon: vehicles[index]["icon"].toString(),
                    tapped: vehicles[index]["tapped"].toString(),
                  ),
                );
              },
              itemCount: vehicles.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 60.h),
          Stack(
            children: [
              Row(
                children: [
                  SizedBox(width: 60.w),
                  Image.asset("assets/images/Line.png"),
                  SizedBox(width: 25.w),
                  SizedBox(
                    height: 380.h,
                    width: 190.w,
                    child: Positioned(
                      bottom: 0.h,
                      left: 30.w,
                      child: Image.asset(defaultImg),
                    ),
                  ),
                  SizedBox(width: 25.w),
                  Image.asset("assets/images/Line.png"),
                ],
              ),
              Positioned(
                left: 125.w,
                bottom: 70.h,
                child: InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=> ####))
                  },
                  child: CircleAvatar(
                    radius: 70.h,
                    backgroundColor: Appcolors.mainYellow,
                    child: Uihelper.customText(
                      text: "      Start \n to add ${defaultVeh.toLowerCase()}",
                      color: Appcolors.mainBlack,
                      fontWeight: FontWeight.w800,
                      size: 18,
                      fontFamily: "Medium",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
