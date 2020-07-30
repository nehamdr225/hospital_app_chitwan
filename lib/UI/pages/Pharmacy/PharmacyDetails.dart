import 'package:eMed/UI/Widget/FRaisedButton.dart';
import 'package:eMed/UI/core/atoms/DetailPageOptions.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/RowInput.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/core/const.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/pages/Pharmacy/PharmacyForm.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PharmacyDetails extends StatelessWidget {
  final id;
  PharmacyDetails({this.id});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final pharmacy = Provider.of<UserDataStore>(context)
        .pharmacies
        .firstWhere((element) => element['id'] == id);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: WhiteAppBar(
          titleColor: theme.colorScheme.primary,
          title: "Pharmacy Details",
          color: theme.colorScheme.primary,
          share: true,
        ),
      ),
      backgroundColor: theme.colorScheme.background,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 180.0,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: gradientColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white60,
                        //offset: Offset(-4, -4),
                        blurRadius: 3.0,
                        spreadRadius: -12.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: Colors.white60,
                        offset: Offset(-4, -4),
                        blurRadius: 3.0),
                    BoxShadow(
                      color: Color(0xffffffff),
                      offset: Offset(-.9, -.9),
                    ),
                    BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        offset: Offset(.9, .9),
                        blurRadius: 1.0),
                  ],
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    Flexible(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: theme.colorScheme.background,
                          backgroundImage: ExactAssetImage(
                            'assets/images/doctor.png',
                          ),
                        )),
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FancyText(
                              text: pharmacy['name'],
                              fontWeight: FontWeight.w700,
                              size: 18.0,
                              textAlign: TextAlign.left,
                              color: textDark_Yellow,
                            ),
                            SizedBox(height: 5.0),
                            RowInput(
                              title: "Location:  ",
                              defaultStyle: false,
                              titleColor: textDark_Yellow,
                              titleSize: 15.0,
                              caption: pharmacy['address'] ?? 'Not available',
                              capColor: textDark_Yellow,
                              capSize: 15.0,
                            ),
                            RowInput(
                              title: "Contact:  ",
                              defaultStyle: false,
                              titleColor: textDark_Yellow,
                              titleSize: 15.0,
                              caption: pharmacy['phone'],
                              capColor: textDark_Yellow,
                              capSize: 15.0,
                            ),
                            SizedBox(height: 2.0),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                SizedBox(width: 1.0),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 1.0),
                              ],
                            ),
                            SizedBox(height: 2),
                            FancyText(
                              text: " Rating 4.0",
                              color: textDark_Yellow.withOpacity(0.8),
                              size: 13.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                // Text(),
                ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 10.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: Container(
              alignment: Alignment.center,
              height: 90.0,
              child: DetailPageOptions(
                listViews: Detail_Options,
              )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0),
          child: FRaisedButton(
            elevation: 1.0,
            width: size.width * 0.95,
            height: 40.0,
            text: "Make Order",
            fontSize: 17.0,
            color: textDark_Yellow,
            bg: theme.colorScheme.secondary.withOpacity(0.8),
            shape: true,
            radius: 5.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PharmacyForm(
                            doctor: pharmacy['name'],
                            department: pharmacy['address'],
                            id: id,
                          )));
            },
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          width: size.width,
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FancyText(
                      text: "Qualification",
                      textAlign: TextAlign.start,
                      size: 15.5,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 2.0),
                    FancyText(
                      text:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                      textAlign: TextAlign.start,
                      size: 13.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ]),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 15.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Icon(
                  Icons.phone,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FancyText(
                        text: "Phone Number: ",
                        textAlign: TextAlign.left,
                        size: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                      FancyText(
                        text: pharmacy['phone'],
                        textAlign: TextAlign.left,
                        size: 16.0,
                        color: theme.colorScheme.secondaryVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ]),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  child: Icon(Icons.phone_forwarded),
                  onPressed: () {
                    // _makePhoneCall(('tel: ${contact[0]}'));
                  }),
            ],
          ),
        ),
      ]),
    );
  }
}
