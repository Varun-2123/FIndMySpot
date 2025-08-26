import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parking_app/Data/services/firebase/store/store.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/Map/mapscreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => HomescreenState();
}

class HomescreenState extends State<Homescreen> {
  var name = "John";
  var vehicles = [
    {
      "icon": "assets/images/car_icon.png",
      "text": "Car",
      "img": "assets/images/Car1.png",
      "tapped": "t",
      "hint": "SUV, Hatchback, Sedan etc.",
    },
    {
      "icon": "assets/images/bike_icon.png",
      "text": "Bike",
      "img": "assets/images/bike1.png",
      "tapped": "f",
      "hint": "Scooter, Sports, Electric etc",
    },
    {
      "icon": "assets/images/bus_icon.png",
      "text": "Bus",
      "img": "assets/images/bus.png",
      "tapped": "f",
      "hint": "Mini Bus, Shuttle, Double-Decker etc.",
    },
  ];
  static var defaultImg = "assets/images/Car1.png";
  static var defaultVeh = "Car";
  var defaultHint = "SUV, Hatchback, Sedan, etc.";

  var modelNameController = TextEditingController();

  var modelTypeController = TextEditingController();

  var numberPlateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      drawer: Uihelper.buildDrawer(context: context),
      body: Column(
        children: [
          // Profile
          SizedBox(height: 60.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Image.asset(
                      "assets/images/Profile.png",
                      height: 60.h,
                      width: 60.w,
                    ),
                  );
                },
              ),
              SizedBox(width: 220.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Mapscreen()),
                  );
                },
                child: Icon(FontAwesomeIcons.locationDot, size: 38.sp),
              ),
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

          // vehicles Selections
          Expanded(
            child: SizedBox(
              height: 175.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        defaultHint = vehicles[index]["hint"].toString();
                        defaultImg = vehicles[index]["img"].toString();
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
              ),
            ),
          ),
          SizedBox(height: 60.h),

          // vehicles image & add vehicle
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
                    child: Image.asset(defaultImg),
                  ),
                  SizedBox(width: 25.w),
                  Image.asset("assets/images/Line.png"),
                ],
              ),

              // add vehicle button
              Positioned(
                left: 125.w,
                bottom: 70.h,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset),
                          child: Wrap(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 40.h),
                                      Uihelper.customText(
                                        text: "Add $defaultVeh",
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        size: 32,
                                      ),
                                      SizedBox(height: 20.h),
                                      Row(
                                        children: [
                                          SizedBox(width: 10.w),
                                          Uihelper.customText(
                                            text: "Details",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            size: 25,
                                          ),
                                        ],
                                      ),
                                      // Model name
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        width: 330.w,
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          controller: modelNameController,
                                          decoration: InputDecoration(
                                            labelText: "Model Name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Vehicle Type
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        width: 330.w,
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          controller: modelTypeController,
                                          decoration: InputDecoration(
                                            labelText: "Model Type",
                                            hintText: defaultHint,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Vehicle Number
                                      SizedBox(height: 20.h),
                                      SizedBox(
                                        width: 330.w,
                                        child: TextField(
                                          keyboardType: TextInputType.text,
                                          controller: numberPlateController,
                                          decoration: InputDecoration(
                                            labelText: "Number Plate",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // save button
                                      SizedBox(height: 40.h),
                                      InkWell(
                                        onTap: () async {
                                          // checking for invalid details
                                          if (modelNameController
                                                  .text
                                                  .isEmpty ||
                                              modelTypeController
                                                  .text
                                                  .isEmpty ||
                                              numberPlateController
                                                  .text
                                                  .isEmpty) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    Expanded(
                                                      child: const Text(
                                                        "All Fields are required!",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                backgroundColor: Colors.red,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: const EdgeInsets.only(
                                                  top: 40, // distance from top
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 760,
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          } else {
                                            // saving the details
                                            final flag =
                                                await Store.uploadVehicle(
                                                  type: defaultVeh,
                                                  vehicleNameController:
                                                      modelNameController,
                                                  vehicleTypeController:
                                                      modelTypeController,
                                                  vehicleLicenseController:
                                                      numberPlateController,
                                                  context: context,
                                                );
                                            // navigation'
                                            if (context.mounted && flag) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => Mapscreen(),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Uihelper.yellowButton(
                                          text: "Save $defaultVeh",
                                        ),
                                      ),
                                      SizedBox(height: 40.h),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
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
