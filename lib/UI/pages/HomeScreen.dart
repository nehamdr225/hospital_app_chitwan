import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/AppBarW.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBarW()
      )
    );
  }
}