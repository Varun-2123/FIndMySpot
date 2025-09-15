import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Domain/constants/Components.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Completedscreen extends StatefulWidget {
  final String id;
  const Completedscreen({super.key, required this.id});

  @override
  State<Completedscreen> createState() => _CompletedscreenState();
}

class _CompletedscreenState extends State<Completedscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: Retrieve.getParkingInfoById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No parking data found"));
          }
          final data = snapshot.data!.data()!;
          return Center(
            child: Column(
              children: [
                // firebase retrival
                SizedBox(height: 60.h),
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
                // main body
                SizedBox(height: 25.h),
                // cars name retrival
                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: Retrieve.getVehicleById(data["VehicleID"]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Center(child: Text("No parking data found"));
                    }
                    final data2 = snapshot.data!.data()!;
                    final veh = data2["Vtype"];
                    return Column(
                      children: [
                        Uihelper.customText(
                          text: data2["Name"],
                          color: Appcolors.mainBlack,
                          fontWeight: FontWeight.bold,
                          size: 38,
                          fontFamily: "Regular",
                        ),
                        Uihelper.customText(
                          text: "${HomescreenState.name}'s $veh",
                          color: Appcolors.grey4,
                          fontWeight: FontWeight.normal,
                          size: 22,
                          fontFamily: "Medium",
                        ),
                        SizedBox(height: 25.h),

                        Uihelper.customText(
                          text:
                              "Price:  ${Components.currency}${data["Price"]}",
                          color: Appcolors.mainBlack,
                          fontWeight: FontWeight.w400,
                          size: 18,
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          height: 64.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Appcolors.mainGreen,
                          ),
                          child: Center(
                            child: Uihelper.customText(
                              text: "Completed",
                              color: Appcolors.mainWhite,
                              fontWeight: FontWeight.normal,
                              size: 22,
                            ),
                          ),
                        ),
                        SizedBox(height: 55.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 65.0),
                          child: Row(
                            children: [
                              Image.asset("assets/images/Line.png"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 27.0,
                                ),
                                child: SizedBox(
                                  height: 380.h,
                                  width: 190.w,
                                  child: Image.asset(
                                    "assets/images/${veh}1.png",
                                  ),
                                ),
                              ),
                              Image.asset("assets/images/Line.png"),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  },
                  child: Uihelper.yellowButton(text: "Done"),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
