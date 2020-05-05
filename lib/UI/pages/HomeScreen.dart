import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: WhiteAppBar(
          logo: true,
            settings: false,
        )
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(
        children:<Widget>[
          
        ]
      ),
    );
  }
}