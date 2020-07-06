import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final checkValue;
  const Indicator(this.checkValue) : super();

  @override
  Widget build(BuildContext context) {
    return checkValue != null ? SizedBox.shrink() : LinearProgressIndicator();
  }
}

class BoolIndicator extends StatelessWidget {
  final checkValue;
  const BoolIndicator(this.checkValue) : super();

  @override
  Widget build(BuildContext context) {
    return !checkValue ? SizedBox.shrink() : LinearProgressIndicator();
  }
}
