import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/GridList.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.bottomCenter,
                height: size.height,
                child: Image.asset(
                  "assets/images/illustration.png",
                  fit: BoxFit.fitWidth,
                )),
            IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: theme.primary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    child: FancyText(
                      text: "Login As",
                      size: 22.0,
                      fontWeight: FontWeight.w800,
                      color: theme.primary,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                      ),
                      width: size.width * 0.80,
                      height: size.height * 0.70,
                      child: GridList(
                        listViews: Options,
                        crossAxisCount: 2
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
