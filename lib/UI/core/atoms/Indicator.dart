import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final checkValue;
  const Indicator(this.checkValue) : super();

  @override
  Widget build(BuildContext context) {
    return checkValue != null
        ? SizedBox.shrink()
        : LinearProgressIndicator(
            backgroundColor: blueGrey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(blueGrey),
          );
  }
}

class BoolIndicator extends StatelessWidget {
  final checkValue;
  const BoolIndicator(this.checkValue) : super();

  @override
  Widget build(BuildContext context) {
    return !checkValue
        ? SizedBox.fromSize(
            size: Size.fromHeight(1),
          )
        : LinearProgressIndicator(
            backgroundColor: blueGrey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(blueGrey),
          );
  }
}
