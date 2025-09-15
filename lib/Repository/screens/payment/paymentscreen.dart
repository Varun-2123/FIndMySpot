import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Paymentscreen extends StatefulWidget {
  final String parkingId;
  const Paymentscreen({super.key, required this.parkingId});
  @override
  State<Paymentscreen> createState() => _PaymentscreenState();
}

class _PaymentscreenState extends State<Paymentscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: Retrieve.getParkingInfoById(widget.parkingId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No parking data found"));
          }
          final data = snapshot.data!.data()!;
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return Center(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/QrCode.png',
                                        fit: BoxFit.cover,
                                        height: 500.h,
                                        width: 330.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(
                        FontAwesomeIcons.qrcode,
                        size: 35.sp,
                        color: Appcolors.mainGreen,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Uihelper.customText(
                      text: "Parking \ntickets \ndetails",
                      color: Appcolors.mainBlack,
                      fontWeight: FontWeight.w600,
                      size: 38,
                      fontFamily: "Medium",
                    ),
                    SizedBox(width: 50.w),
                    Container(
                      height: 85.h,
                      width: 110.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: AssetImage("assets/images/MiniMap.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Icon(FontAwesomeIcons.locationDot, size: 36),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Container(
                  height: 200.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: Appcolors.grey3, width: 2.sp),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 105.h,
                          width: 105.w,
                          decoration: BoxDecoration(
                            color: Appcolors.mainGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Uihelper.customText(
                              text: "P",
                              color: Appcolors.mainWhite,
                              fontWeight: FontWeight.bold,
                              size: 55,
                              fontFamily: "Bold",
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        SizedBox(
                          height: 205.h,
                          width: 135.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Uihelper.customText(
                                text: widget.parkingId.substring(0, 8),
                                color: Appcolors.mainBlack,
                                fontWeight: FontWeight.w600,
                                size: 25,
                                fontFamily: "Medium",
                              ),
                              Uihelper.customText(
                                text: "AUTO MOBILE",
                                color: Appcolors.grey5,
                                fontWeight: FontWeight.w600,
                                size: 18,
                                fontFamily: "Medium",
                              ),
                              SizedBox(height: 20.h),
                              Uihelper.customText(
                                text: "Zone - ${data["Zone"]}",
                                color: Appcolors.mainBlack,
                                fontWeight: FontWeight.w600,
                                size: 20,
                              ),
                              StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>
                              >(
                                stream: Retrieve.getVehicleById(
                                  data["VehicleID"],
                                ),
                                builder: (context, nameSnapshot) {
                                  if (nameSnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Uihelper.customText(
                                      text: "Loading Name...",
                                      color: Appcolors.mainBlack,
                                      fontWeight: FontWeight.w600,
                                      size: 15,
                                    );
                                  }
                                  if (!nameSnapshot.hasData ||
                                      !nameSnapshot.data!.exists) {
                                    return Uihelper.customText(
                                      text: "Name not available",
                                      color: Appcolors.mainBlack,
                                      fontWeight: FontWeight.w600,
                                      size: 15,
                                    );
                                  }
                                  final nameData = nameSnapshot.data!.data()!;
                                  return Uihelper.customText(
                                    text: nameData["Name"],
                                    color: Appcolors.mainBlack,
                                    fontWeight: FontWeight.w600,
                                    size: 15,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Row(
                  children: [
                    Uihelper.customText(
                      text: "Log Activities",
                      color: Appcolors.mainBlack,
                      fontWeight: FontWeight.w400,
                      size: 25,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Container(
                      height: 100.h,
                      width: 3.w,
                      color: Appcolors.mainBlack,
                    ),
                    SizedBox(width: 3.w),
                    Container(
                      height: 100.h,
                      width: 3.w,
                      color: Appcolors.mainGreen,
                    ),
                    SizedBox(width: 20.w),
                    SizedBox(
                      height: 100.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Uihelper.customText(
                            text: data["StartTime"],
                            color: Appcolors.mainBlack,
                            fontWeight: FontWeight.normal,
                            size: 20,
                          ),
                          Uihelper.customText(
                            text: data["EndTime"],
                            color: Appcolors.mainBlack,
                            fontWeight: FontWeight.normal,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 60.w),
                    Uihelper.customText(
                      text: DateFormat(
                        'dd/MM/yyyy',
                      ).format((data["Date"] as Timestamp).toDate()),
                      color: Appcolors.mainBlack,
                      fontWeight: FontWeight.w600,
                      size: 20,
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
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
          );
        },
      ),
    );
  }
}
