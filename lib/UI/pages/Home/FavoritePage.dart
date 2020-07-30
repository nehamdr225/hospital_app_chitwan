import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/pages/Home/HomeListCard.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final favourites = Provider.of<UserDataStore>(context).favourites;

    return favourites != null && favourites.length > 0
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
              itemCount: favourites.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeListCard(
                  id: favourites[index].favId,
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
