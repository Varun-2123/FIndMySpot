import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  final List<String> zones = [
    "A-013",
    "A-022",
    "C-007",
    "B-105",
    "C-123",
    "E-013",
    "A-111",
    "B-689",
  ];
  // TimeOfDay? selectedTime;

  // String getDisplayedTime(BuildContext context) {
  //   final time = selectedTime ?? TimeOfDay.now();
  //   return time.format(context);
  // }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Map.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60.h),
            Row(
              children: [
                SizedBox(width: 20.w),
                Container(
                  height: 55.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    // color: Appcolors.grey2,
                    // color: Colors.amber,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    },
                    child: Icon(FontAwesomeIcons.chevronLeft, size: 22.sp),
                  ),
                ),
                SizedBox(width: 60.w),
                Uihelper.customText(
                  text: "Parking Map",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.bold,
                  size: 19,
                  fontFamily: "Bold",
                ),
              ],
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 800.h,
              width: 380.w,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 1
                  Positioned(
                    top: 0,
                    left: 100,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[0],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 2
                  Positioned(
                    top: 80,
                    left: 180,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[1],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 3
                  Positioned(
                    top: 150,
                    right: 60,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[2],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 4
                  Positioned(
                    top: 180,
                    left: 60,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[3],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 5
                  Positioned(
                    top: 320,
                    left: 200,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[4],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 6
                  Positioned(
                    bottom: 140,
                    left: 50,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[5],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 7
                  Positioned(
                    bottom: 280,
                    left: 85,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[6],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                  // 8
                  Positioned(
                    bottom: 240,
                    right: 60,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                bottomInset,
                              ),
                              child: Wrap(
                                children: [
                                  Uihelper.popUpSheet(
                                    context: context,
                                    zone: zones[7],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Icon(FontAwesomeIcons.locationDot, size: 30.sp),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
