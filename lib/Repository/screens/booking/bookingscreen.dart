import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/completed/completedscreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Bookingscreen extends StatefulWidget {
  const Bookingscreen({super.key});

  @override
  State<Bookingscreen> createState() => _BookingscreenState();
}

class _BookingscreenState extends State<Bookingscreen> {
  var status = "Completed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  text: "All Bookings",
                  color: Appcolors.mainWhite,
                  fontWeight: FontWeight.w600,
                  size: 32,
                  fontFamily: "Medium",
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),

          // white bg part
          StreamBuilder(
            stream: Retrieve.getParkingSnapshot(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No data here :(');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data =
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
                    final sId = snapshot.data!.docs[index].id;
                    var flag = isToday(data["Date"]);
                    if (flag == true) {
                      return Container();
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Completedscreen(id: sId),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 120.h,
                            child: Row(
                              children: [
                                Container(
                                  height: 85.h,
                                  width: 85.w,
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
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 25.h),
                                    SizedBox(
                                      width: 230.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Uihelper.customText(
                                            text: data["Zone"],
                                            color: Appcolors.mainGreen,
                                            fontWeight: FontWeight.w600,
                                            size: 28,
                                            fontFamily: "Medium",
                                          ),
                                          Container(
                                            height: 30.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color:
                                                  isToday(
                                                        data["Date"]
                                                            as Timestamp,
                                                      )
                                                      ? Colors.red
                                                      : Appcolors.mainYellow,
                                            ),
                                            child: Center(
                                              child: Uihelper.customText(
                                                text:
                                                    isToday(
                                                          data["Date"]
                                                              as Timestamp,
                                                        )
                                                        ? "Ongoing"
                                                        : "Completed",

                                                color:
                                                    isToday(
                                                          data["Date"]
                                                              as Timestamp,
                                                        )
                                                        ? Appcolors.mainWhite
                                                        : Appcolors.mainBlack,
                                                fontWeight: FontWeight.w600,
                                                size: 15,
                                                fontFamily: "Medium",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Uihelper.customText(
                                          text:
                                              "${data["StartTime"]} - ${data["EndTime"]}",
                                          color: Appcolors.mainBlack,
                                          fontWeight: FontWeight.normal,
                                          size: 14,
                                        ),
                                        SizedBox(width: 20.w),
                                        Uihelper.customText(
                                          text: DateFormat('dd/MM/yyyy').format(
                                            (data["Date"] as Timestamp)
                                                .toDate(),
                                          ),
                                          color: Appcolors.mainBlack,
                                          fontWeight: FontWeight.normal,
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
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool isToday(Timestamp timestamp) {
    DateTime firestoreDate = timestamp.toDate();
    DateTime now = DateTime.now();

    return firestoreDate.year == now.year &&
        firestoreDate.month == now.month &&
        firestoreDate.day == now.day;
  }
}
