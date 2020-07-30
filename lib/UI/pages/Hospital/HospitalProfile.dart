import 'package:eMed/UI/Widget/FRaisedButton.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/UI/pages/Home/DoctorsTab.dart';
import 'package:eMed/UI/pages/Hospital/HospitalInqury.dart';
import 'package:eMed/UI/pages/Hospital/HospitalNews.dart';
import 'package:eMed/UI/pages/Hospital/HospitalPromo.dart';
import 'package:eMed/models/HospitalPromotion.dart';
import 'package:eMed/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalProfile extends StatelessWidget {
  final id;
  HospitalProfile({this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final userDataStore = Provider.of<UserDataStore>(context);
    final hospital =
        userDataStore.hospitals.firstWhere((element) => element.uid == id);
    final List<HospitalPromotion> promotions = userDataStore.promotions != null
        ? userDataStore.promotions
            .where((element) => element.hospitalId == id)
            .toList()
        : [];

    return Scaffold(
      backgroundColor: theme.background,
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          expandedHeight: 250.0,
          floating: true,
          pinned: true,
          snap: true,
          elevation: 1.0,
          backgroundColor: theme.primary,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Text(hospital.name,
                    style: TextStyle(
                      color: theme.background,
                      fontSize: 15.0,
                    )),
              ),
              background: Stack(
                children: <Widget>[
                  Container(
                    height: 285.0,
                    color: theme.background,
                  ),
                  Container(
                    width: size.width,
                    height: 240.0,
                    color: theme.primary,
                    child: Image.asset(
                      "assets/images/img5.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, bottom: 15.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          backgroundColor: theme.secondary,
                          child: Icon(Icons.contacts, color: textDark_Yellow),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => HospitalInquiryForm(
                                  id: id,
                                  name: hospital.name,
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              )),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(left: 44.0, top: 0.0),
          child: FancyText(
            text: hospital.name,
            fontWeight: FontWeight.w500,
            size: 21.0,
            textAlign: TextAlign.start,
          ),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 14.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    color: Colors.grey[500],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FancyText(
                      text: "About",
                      fontWeight: FontWeight.w500,
                      size: 19.0,
                      color: theme.primary.withOpacity(0.8),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 33.0, right: 20.0, top: 6.0),
                child: FancyText(
                    textOverflow: TextOverflow.visible,
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,
                    textAlign: TextAlign.left,
                    color: Colors.black87,
                    size: 15.0,
                    text: hospital.about ?? 'Not Available'),
              ),
            ],
          ),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(left: 10.0, top: 14.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.photo,
                    color: Colors.grey[500],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: FancyText(
                      text: "Promotions",
                      fontWeight: FontWeight.w500,
                      size: 19.0,
                      color: theme.primary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 14.0, right: 10.0, left: 10.0),
              child: Container(
                  alignment: Alignment.center,
                  height: 130.0,
                  child: HospitalPromo(
                    promotions: promotions,
                  )),
            ),
          ]),
        )),
        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 14.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: Colors.grey[500],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: FancyText(
                            text: "Specialities",
                            fontWeight: FontWeight.w500,
                            size: 19.0,
                            color: theme.primary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 0.0, top: 14.0),
                    child: FancyText(
                        letterSpacing: 1.0,
                        wordSpacing: 2.0,
                        textAlign: TextAlign.left,
                        textOverflow: TextOverflow.visible,
                        color: Colors.black87,
                        size: 15.0,
                        text: hospital.departments != null
                            ? hospital.departments.replaceAll(';', ', ')
                            : 'Not available'),
                  ),
                ]))),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(left: 14.0, top: 25.0, right: 14.0),
          child: FRaisedButton(
            elevation: 1.0,
            width: size.width * 0.95,
            height: 40.0,
            text: "See Doctors List",
            fontSize: 17.0,
            color: textDark_Yellow,
            bg: theme.secondary.withOpacity(0.8),
            shape: true,
            radius: 5.0,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DoctorsTab()));
            },
          ),
        )),
        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(left: 10.0, top: 14.0),
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.new_releases,
                          color: Colors.grey[500],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: FancyText(
                            text: "News",
                            fontWeight: FontWeight.w500,
                            size: 19.0,
                            color: theme.primary.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, right: 10.0, left: 10.0, bottom: 10.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 250.0,
                        child: HospitalNews()),
                  ),
                  Container(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      FancyText(
                        text: "Visit Us at:",
                        size: 14.0,
                        defaultStyle: true,
                      ),
                      Image.asset(
                        "assets/images/facebookicon.png",
                        height: 50.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ]),
                  )
                ]))),
      ]),
    );
  }
}
