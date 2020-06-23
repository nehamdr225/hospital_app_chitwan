import 'package:flutter/material.dart';

class BlankLoader extends StatelessWidget {
  const BlankLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
