import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/HoizontalList.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeListCard.dart';
import 'package:chitwan_hospital/UI/pages/SubsPage/atoms/ListCard.dart';
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
          Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                    height: 110.0,
                    child: HorizontalList( 
                      listViews: Options,
                    )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FancyText(
              text: "Featured",
              fontWeight: FontWeight.w600,
              color: theme.textTheme.body1.color,
              size: 17.0,
              textAlign: TextAlign.left,
            ),
          ),
          HomeListCard(
              name: NearYou[0]['name'],
              caption: NearYou[0]['cap'],
              image: NearYou[0]['src'],
              phone: NearYou[0]['phone'],
              status: NearYou[0]['status'],
              date: NearYou[0]['date'],
              time:NearYou[0]['time'],
            ),
        
        ]
      ),
    );
  }
}