import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color.fromARGB(255, 2, 3, 39),
            child: Column(
              children: [
                SizedBox(height: 60.h),
                Row(
                  children: [
                    SizedBox(width: 15.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 55.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Appcolors.grey2,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Icon(FontAwesomeIcons.chevronLeft, size: 22.sp),
                      ),
                    ),
                    SizedBox(width: 15.w),
                  ],
                ),
                SizedBox(height: 15.h),
                Uihelper.customText(
                  text: "Personal info",
                  color: Appcolors.mainWhite,
                  fontWeight: FontWeight.w600,
                  size: 32,
                  fontFamily: "Medium",
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),

          // main body
          // for image display and edit
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircleAvatar(
              radius: 70.w,
              backgroundColor: Colors.blueGrey,
              backgroundImage: AssetImage("assets/images/Profile.png"),
            ),
          ),
          // info
          // name
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Uihelper.customText(
                  text: "Name",
                  color: Appcolors.grey7,
                  fontWeight: FontWeight.normal,
                  size: 16,
                ),
                Uihelper.customText(
                  text: "John Doe",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.normal,
                  size: 24,
                  fontFamily: "Medium",
                ),
              ],
            ),
          ),
          // Gender
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Uihelper.customText(
                  text: "Gender",
                  color: Appcolors.grey7,
                  fontWeight: FontWeight.normal,
                  size: 16,
                ),
                Uihelper.customText(
                  text: "Male",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.normal,
                  size: 24,
                ),
              ],
            ),
          ),
          //phone no
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Uihelper.customText(
                  text: "Phone no.",
                  color: Appcolors.grey7,
                  fontWeight: FontWeight.normal,
                  size: 16,
                ),
                Uihelper.customText(
                  text: "+91 123456996",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.normal,
                  size: 24,
                ),
              ],
            ),
          ),

          //email
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 22.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Uihelper.customText(
                  text: "Email",
                  color: Appcolors.grey7,
                  fontWeight: FontWeight.normal,
                  size: 16,
                ),
                Uihelper.customText(
                  text: "emailemail@gmail.com",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.normal,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
