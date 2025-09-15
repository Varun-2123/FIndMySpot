import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Retrieve {
  // retrieving user specific vehicles
  // instance or a stream builder output
  static Stream<QuerySnapshot> getVehiclesSnapshot() {
    return FirebaseFirestore.instance
        .collection('vehicles')
        .where('Creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // retrieving user specific vehicles
  // instance or a stream builder output
  static Stream<QuerySnapshot> getParkingSnapshot() {
    return FirebaseFirestore.instance
        .collection('parking_info')
        .where('Creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // retrieving user information of the user stored in instance
  static Stream<QuerySnapshot> getPersonalInfo() {
    return FirebaseFirestore.instance
        .collection("personal_info")
        .where('Creator', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  // retrieving parking Info
  // snapshot output
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getParkingInfoById(
    String docId,
  ) {
    try {
      return FirebaseFirestore.instance
          .collection("parking_info")
          .doc(docId)
          .snapshots();
    } catch (e) {
      throw Exception("Error fetching document: $e");
    }
  }

  // get vehicle by id
  static Stream<DocumentSnapshot<Map<String, dynamic>>> getVehicleById(
    String vehId,
  ) {
    try {
      return FirebaseFirestore.instance
          .collection("vehicles")
          .doc(vehId)
          .snapshots();
    } catch (e) {
      throw Exception("Error fetching document: $e");
    }
  }
}
