import 'package:flutter/material.dart';

class Vehiclesscreen extends StatefulWidget {
  const Vehiclesscreen({super.key});

  @override
  State<Vehiclesscreen> createState() => _VehiclesscreenState();
}

class _VehiclesscreenState extends State<Vehiclesscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Vehicles")));
  }
}
