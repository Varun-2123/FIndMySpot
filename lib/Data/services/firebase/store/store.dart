import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';

class Store {
  // Upload Vehicle
  static Future<bool> uploadVehicle({
    required String type,
    required TextEditingController vehicleNameController,
    required TextEditingController vehicleTypeController,
    required TextEditingController vehicleLicenseController,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection("vehicles").add({
        "Vtype": type,
        "Name": vehicleNameController.text.trim(),
        "Type": vehicleTypeController.text.trim(),
        "License": vehicleLicenseController.text.trim(),
        "Creator": FirebaseAuth.instance.currentUser!.uid,
      });
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text(
                    e.message ?? 'An unknown error occurred',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Appcolors.mainYellow,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(
              top: 40,
              left: 10,
              right: 10,
              bottom: 760,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return false;
    }
  }

  // upload parking details
  static Future<String> uploadParkingInfo({
    required BuildContext context,
    required String zone,
    required int price,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required int minutes,
    required String duration,
    required String vehicleId,
  }) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("parking_info")
          .add({
            "Zone": zone,
            "Price": price,
            "StartTime": startTime.format(context),
            "EndTime": endTime.format(context),
            "Minutes": minutes,
            "Duration": duration,
            "VehicleID": vehicleId,
            "Date": FieldValue.serverTimestamp(),
            "Creator": FirebaseAuth.instance.currentUser!.uid,
          });
      String docId = docRef.id;
      return docId;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Expanded(
                  child: Text(
                    e.message ?? 'An unknown error occurred',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Appcolors.mainYellow,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(
              top: 40,
              left: 10,
              right: 10,
              bottom: 760,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return 'failed';
    }
  }
}
