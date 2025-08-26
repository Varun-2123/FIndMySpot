import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Data/services/firebase/store/store.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Domain/constants/Components.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/screens/payment/paymentscreen.dart';

Future<TimeOfDay?> pickTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  return picked;
}

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

  static loginButton({required String text, Color? color}) {
    var textColor = Colors.black;
    if (color == null) {
      textColor = Colors.black;
      color = Appcolors.grey2;
    }
    return Container(
      height: 50.h,
      width: 320.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: customText(
          text: text,
          color: textColor,
          fontWeight: FontWeight.normal,
          size: 20,
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
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  static yellowButton({required String text}) {
    return Container(
      height: 85.h,
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Appcolors.mainYellow,
      ),
      child: Center(
        child: customText(
          text: text,
          color: Appcolors.mainBlack,
          fontWeight: FontWeight.w400,
          fontFamily: "Medium",
          size: 25,
        ),
      ),
    );
  }

  static Future<void> popUpSheet2({
    required BuildContext context,
    required String zone,
    required int price,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required int minutes,
    required String duration,
  }) {
    int? selectedIndex;
    String vehicleId = "";
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: "Vehicles",
                          color: Appcolors.mainBlack,
                          fontWeight: FontWeight.bold,
                          size: 38,
                          fontFamily: "Medium",
                        ),
                        customText(
                          text: "Select your vehicle",
                          color: Appcolors.grey4,
                          fontWeight: FontWeight.normal,
                          size: 20,
                        ),
                        SizedBox(height: 20.h),
                        // showing vehicles
                        // retrieve from database
                        StreamBuilder(
                          stream: Retrieve.getVehiclesSnapshot(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Text('No data here :(');
                            }
                            return SizedBox(
                              height: 280.h,
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  final data =
                                      snapshot.data!.docs[index].data()
                                          as Map<String, dynamic>;
                                  final sId = snapshot.data!.docs[index].id;
                                  final isSelected = selectedIndex == index;
                                  final sColor =
                                      isSelected
                                          ? Appcolors.mainBlack
                                          : Appcolors.mainWhite;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          vehicleId = sId;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30.0,
                                          ),
                                          border: Border.all(
                                            color: sColor,
                                            width: 2.sp,
                                          ),
                                        ),
                                        height: 120.h,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 85.h,
                                              width: 85.w,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Appcolors.grey3,
                                                  width: 1.5.sp,
                                                ),
                                              ),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/images/${(data["Vtype"] as String).toLowerCase()}_icon.png",
                                                  height: 40.h,
                                                  width: 40.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 15.h),
                                                customText(
                                                  text: data["Name"],
                                                  color: Appcolors.mainGreen,
                                                  fontWeight: FontWeight.w600,
                                                  size: 28,
                                                  fontFamily: "Medium",
                                                ),
                                                Row(
                                                  children: [
                                                    customText(
                                                      text: data["Type"],
                                                      color:
                                                          Appcolors.mainBlack,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      size: 14,
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    customText(
                                                      text: data["License"],
                                                      color:
                                                          Appcolors.mainBlack,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      size: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 10.h),
                        // ticket details
                        customText(
                          text: "Ticket Details",
                          color: Appcolors.mainBlack,
                          fontWeight: FontWeight.normal,
                          size: 32,
                          fontFamily: "Medium",
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 125.h,
                              width: 125.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Appcolors.grey5,
                                  width: 1.sp,
                                ),
                              ),
                              child: Center(
                                child: customText(
                                  text: "P",
                                  color: Appcolors.mainGreen,
                                  fontWeight: FontWeight.bold,
                                  size: 60,
                                  fontFamily: "Bold",
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            SizedBox(
                              width: 160.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  customText(
                                    text: zone,
                                    color: Appcolors.mainGreen,
                                    fontWeight: FontWeight.w700,
                                    size: 38.sp,
                                    fontFamily: "Medium",
                                  ),
                                  SizedBox(height: 5.h),
                                  customText(
                                    text: "Parking Hours",
                                    color: Appcolors.grey4,
                                    fontWeight: FontWeight.normal,
                                    size: 20.sp,
                                    fontFamily: "Medium",
                                  ),

                                  customText(
                                    text:
                                        "${startTime.format(context)} - ${endTime.format(context)}",
                                    color: Appcolors.mainBlack,
                                    fontWeight: FontWeight.normal,
                                    size: 15.sp,
                                    fontFamily: "Medium",
                                  ),
                                  SizedBox(height: 10.h),
                                  customText(
                                    text: "Total",
                                    color: Appcolors.grey4,
                                    fontWeight: FontWeight.normal,
                                    size: 20.sp,
                                    fontFamily: "Medium",
                                  ),
                                  Row(
                                    children: [
                                      customText(
                                        text: "${Components.currency} $price",
                                        color: Appcolors.mainBlack,
                                        fontWeight: FontWeight.w600,
                                        size: 30.sp,
                                        fontFamily: "Medium",
                                      ),
                                      SizedBox(width: 5.w),
                                      customText(
                                        text: "${Components.currency}100/hr",
                                        color: Appcolors.mainBlack,
                                        fontWeight: FontWeight.normal,
                                        size: 12.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        InkWell(
                          onTap: () async {
                            final flag = await Store.uploadParkingInfo(
                              context: context,
                              zone: zone,
                              price: price,
                              startTime: startTime,
                              endTime: endTime,
                              minutes: minutes,
                              duration: duration,
                              vehicleId: vehicleId,
                            );
                            if (context.mounted && flag != "failed") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          Paymentscreen(parkingId: flag),
                                ),
                              );
                            }
                          },
                          child: yellowButton(text: "Continue"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget popUpSheet({
    required BuildContext context,
    required String zone,
  }) {
    TimeOfDay? selectedTime;
    TimeOfDay? selectedTime2;
    int price = 200;
    String duration = "02:00";
    int minutes = 120;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        String getDisplayedTime(BuildContext context) {
          final time = selectedTime ?? TimeOfDay.now();
          selectedTime = time;
          return time.format(context);
        }

        String getDisplayedTime2(BuildContext context) {
          if (selectedTime2 != null) {
            return selectedTime2!.format(context);
          } else {
            final now = TimeOfDay.now();
            final twoHoursLater = TimeOfDay(
              hour: (now.hour + 2) % 24,
              minute: now.minute,
            );
            selectedTime2 = twoHoursLater;
            return twoHoursLater.format(context);
          }
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  customText(
                    text: "Book Your ${HomescreenState.defaultVeh}",
                    color: Appcolors.mainBlack,
                    fontWeight: FontWeight.normal,
                    size: 32,
                    fontFamily: "Medium",
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 20.w),
                  customText(
                    text: "Parking",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    size: 34,
                    fontFamily: "Bold",
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                height: 200.h,
                width: 320.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Appcolors.grey4, width: 1.sp),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 18.0,
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 100.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText(
                                  text: "Zone",
                                  color: Appcolors.grey4,
                                  fontWeight: FontWeight.normal,
                                  size: 20,
                                ),
                                customText(
                                  text: zone,
                                  color: Appcolors.mainBlack,
                                  fontWeight: FontWeight.normal,
                                  size: 36,
                                  fontFamily: "Medium",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 70.w),
                          Container(
                            height: 85.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage("assets/images/MiniMap.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 12.h,
                                  left: 40.w,
                                  child: Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: customText(
                        text: "Time Slot",
                        color: Appcolors.grey4,
                        fontWeight: FontWeight.normal,
                        size: 18,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 18.w),
                        InkWell(
                          onTap: () async {
                            final time = await pickTime(context);
                            if (time != null) {
                              setState(() {
                                selectedTime = time;
                                if (selectedTime != null &&
                                    selectedTime2 != null) {
                                  minutes =
                                      getTimeDifferenceInMinutesFromTimeOfDay(
                                        selectedTime!,
                                        selectedTime2!,
                                      );
                                  price = (minutes * 1.67).toInt();
                                  duration = convertMinutesToHHMM(minutes);
                                }
                              });
                            }
                          },
                          child: customText(
                            text: getDisplayedTime(context),
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            size: 18,
                            fontFamily: "Medium",
                          ),
                        ),

                        customText(
                          text: " - ",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          size: 18,
                          fontFamily: "Medium",
                        ),
                        InkWell(
                          onTap: () async {
                            final time = await pickTime(context);
                            if (time != null) {
                              setState(() {
                                selectedTime2 = time;
                                if (selectedTime != null &&
                                    selectedTime2 != null) {
                                  int minutes =
                                      getTimeDifferenceInMinutesFromTimeOfDay(
                                        selectedTime!,
                                        selectedTime2!,
                                      );
                                  price = (minutes * 1.67).toInt();
                                  duration = convertMinutesToHHMM(minutes);
                                }
                              });
                            }
                          },
                          child: customText(
                            text: getDisplayedTime2(context),
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            size: 18,
                            fontFamily: "Medium",
                          ),
                        ),
                        SizedBox(width: 50.w),
                        customText(
                          text: "${Components.currency} $price",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          size: 20,
                          fontFamily: "Medium",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  popUpSheet2(
                    context: context,
                    zone: zone,
                    price: price,
                    startTime: selectedTime!,
                    endTime: selectedTime2!,
                    minutes: minutes,
                    duration: duration,
                  );
                },
                child: yellowButton(text: "Start Booking"),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }

  static getTimeDifferenceInMinutesFromTimeOfDay(
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) {
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    // Handle next day scenario
    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }

    return endMinutes - startMinutes;
  }

  static String convertMinutesToHHMM(int totalMinutes) {
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }
}
