import 'package:flutter/material.dart';

class Ticketsscreen extends StatefulWidget {
  const Ticketsscreen({super.key});

  @override
  State<Ticketsscreen> createState() => _TicketsscreenState();
}

class _TicketsscreenState extends State<Ticketsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Tickets")));
  }
}
