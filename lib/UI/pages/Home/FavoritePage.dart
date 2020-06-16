import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Home/HomeListCard.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final items = NearYou;
    return items.length > 0
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: WhiteAppBar(
                backgroundColor: theme.background,
                title: 'Favorites',
                titleColor: theme.primary,
              ),
            ),
            backgroundColor: theme.background,
            body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return HomeListCard(
                  doctorName: NearYou[index]['name'],
                  department: NearYou[index]['cap'],
                  image: NearYou[index]['src'],
                  phone: NearYou[index]['phone'],
                  status: NearYou[index]['status'],
                  date: NearYou[index]['date'],
                  time: NearYou[index]['time'],
                );
              },
            ))
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.0),
              child: WhiteAppBar(
                backgroundColor: Colors.white,
                title: 'Favorites',
                titleColor: theme.primary,
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/nothingHere.png",
                  height: 250.0,
                ),
                FancyText(
                    text: "You have not added favorites yet.",
                    defaultStyle: true,
                    size: 17.0),
              ],
            )));
  }
}
