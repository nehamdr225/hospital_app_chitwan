import 'package:chitwan_hospital/UI/core/atoms/GridList.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
          child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: <Widget>[
            Container(
                height: size.height,
                child: Image.asset(
                  "assets/images/img2.jpeg",
                  fit: BoxFit.fitHeight,
                )),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textDark_Yellow,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridList(
                listViews: Options,
                crossAxisCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
