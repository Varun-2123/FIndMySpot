import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Domain/constants/Components.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Progressscreen extends StatefulWidget {
  final String id;
  const Progressscreen({super.key, required this.id});

  @override
  State<Progressscreen> createState() => _ProgressscreenState();
}

class _ProgressscreenState extends State<Progressscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Row(
              children: [
                SizedBox(width: 25.w),
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
              ],
            ),
            SizedBox(height: 15.h),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: Retrieve.getParkingInfoById(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Center(child: Text("No parking data found"));
                }
                final data = snapshot.data!.data()!;
                return Column(
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: Retrieve.getVehicleById(data["VehicleID"]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const Center(
                            child: Text("No parking data found"),
                          );
                        }
                        final data2 = snapshot.data!.data()!;
                        return Column(
                          children: [
                            Uihelper.customText(
                              text: data2["Name"],
                              color: Appcolors.mainBlack,
                              fontWeight: FontWeight.w600,
                              size: 40,
                              fontFamily: "Medium",
                            ),
                            Uihelper.customText(
                              // personal info recall
                              text:
                                  "${HomescreenState.name}'s ${data2["Vtype"]}",
                              color: Appcolors.grey4,
                              fontWeight: FontWeight.w600,
                              size: 18,
                            ),
                            SizedBox(height: 38.h),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Price  ${Components.currency}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Appcolors.grey6,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${data["Price"]}",
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Appcolors.grey6,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Container(
                              height: 225.h,
                              width: 225.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Appcolors.mainGreen,
                                  width: 18.sp,
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  height: 125.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/Line.png"),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                        ),
                                        child: Image.asset(
                                          "assets/images/${data2["Vtype"]}1.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Image.asset("assets/images/Line.png"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        SizedBox(width: 97.w),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${data["Duration"]}",
                                style: TextStyle(
                                  color: Appcolors.mainBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 50.sp,
                                  fontFamily: "Medium",
                                ),
                              ),
                              TextSpan(
                                text: " Hour",
                                style: TextStyle(
                                  color: Appcolors.grey3,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.sp,
                                  fontFamily: "Medium",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Uihelper.customText(
                      text:
                          "     ${data["EndTime"]}  -  ${DateFormat('dd/MM/yyyy').format((data["Date"] as Timestamp).toDate())}",
                      color: Appcolors.grey4,
                      fontWeight: FontWeight.w400,
                      size: 15,
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      height: 135.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                        color: Appcolors.mainBlack,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Uihelper.customText(
                                  text: "Zone",
                                  color: Appcolors.grey1,
                                  fontWeight: FontWeight.normal,
                                  size: 18,
                                ),
                                Uihelper.customText(
                                  text: "${data["Zone"]}",
                                  color: Appcolors.grey2,
                                  fontWeight: FontWeight.w700,
                                  size: 25,
                                ),
                              ],
                            ),
                            Container(
                              height: 90.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/MiniMap.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 36.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // main code base
            SizedBox(height: 25.h),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              },
              child: Uihelper.yellowButton(text: "Done"),
            ),
          ],
        ),
      ),
    );
  }
}
