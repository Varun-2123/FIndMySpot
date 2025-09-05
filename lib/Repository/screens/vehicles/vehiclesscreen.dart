import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Data/services/firebase/retrieve/retrieve.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Vehiclesscreen extends StatefulWidget {
  const Vehiclesscreen({super.key});

  @override
  State<Vehiclesscreen> createState() => _VehiclesscreenState();
}

class _VehiclesscreenState extends State<Vehiclesscreen> {
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
                  text: "Saved Vehicles",
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
            stream: Retrieve.getVehiclesSnapshot(),
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

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: SizedBox(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15.h),
                                Uihelper.customText(
                                  text: data["Name"],
                                  color: Appcolors.mainGreen,
                                  fontWeight: FontWeight.w600,
                                  size: 28,
                                  fontFamily: "Medium",
                                ),
                                Row(
                                  children: [
                                    Uihelper.customText(
                                      text: data["Type"],
                                      color: Appcolors.mainBlack,
                                      fontWeight: FontWeight.normal,
                                      size: 14,
                                    ),
                                    SizedBox(width: 20.w),
                                    Uihelper.customText(
                                      text: data["License"],
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
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
