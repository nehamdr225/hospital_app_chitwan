import 'package:flutter/material.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';

class HospitalNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0, bottom: 10.0),
          child: Container(
            width: size.width * 0.80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: theme.background,
              boxShadow: [
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: Offset(-.9, -.9),
                ),
                BoxShadow(
                    color: theme.primary.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: theme.primary.withOpacity(0.3),
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            child: Column(
              children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/img5.jpeg",
                  height: 130.0,
                  width: size.width * 0.80,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FancyText(
                      text: "Covid-19 Informations",
                      size: 16.0,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5.0,),
                    FancyText(
                      text: "Lorem ipsum dolor sit amet, ut labore et dolore magna aliqua.",
                      size: 14.0,
                      fontWeight: FontWeight.w300,
                      textAlign: TextAlign.start,
                    )
                  ]
                )
              )
            ]),
          ),
        );
      },
    );
  }
}
