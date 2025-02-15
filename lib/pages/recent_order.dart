import 'package:flutter/material.dart';

class RecentOrder extends StatefulWidget {
  const RecentOrder({super.key});

  @override
  State<RecentOrder> createState() => _RecentOrderState();
}

class _RecentOrderState extends State<RecentOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent order"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
    );
  }
}