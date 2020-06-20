import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';

class PharmacyReady extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context);
    return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: WhiteAppBar(
                title: "Pharmacy Ready"
              )),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ListView(
              children: <Widget>[
                _buildAddFieldWidget(),
              ]));
  }
  _buildAddFieldWidget(){
    return Form(child: FForms());
  }
}
