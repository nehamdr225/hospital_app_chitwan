import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/pages/Home/DoctorsTab.dart';
import 'package:flutter/material.dart';

class CallList extends DoctorsTab {
  final department;
  final departmentDoctors;

  CallList({this.department, this.departmentDoctors});
  @override
  Widget build(BuildContext context) {
    //var name = "Name".substring(1);
    var size = MediaQuery.of(context).size;
    final List doctorNames = departmentDoctors.keys.toList();
    cardGenerator(doctor) {
      final department = departmentDoctors[doctor]['department'];
      final camelDepart = department[0] + department.substring(1).toLowerCase();
      final contact = departmentDoctors[doctor]['contact'];
      final subD = departmentDoctors[doctor]['sub-department'];
      final camelSub = subD[0] + subD.substring(1).toLowerCase();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.background,
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
                    color: Colors.grey[300],
                    offset: Offset(3, 3),
                    blurRadius: 3.0),
                BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            width: size.width * 0.90,
            height: 150.0,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/doctor.png',
                    height: 100.0,
                    width: 70.0,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FancyText(
                          text: doctor,
                          fontWeight: FontWeight.w700,
                          size: 15.0,
                          textAlign: TextAlign.left,
                        ),
                        contact.length > 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: FancyText(
                                        text: "Contact: ",
                                        textAlign: TextAlign.left,
                                        defaultStyle: true,
                                      ),
                                    ),
                                    FancyText(
                                        text:
                                            "${contact[0].toString()}, ${contact[1].toString()}",
                                        textAlign: TextAlign.left,
                                        fontWeight: FontWeight.w500)
                                  ])
                            : Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: FancyText(
                                      text: "Contact: ",
                                      textAlign: TextAlign.left,
                                      defaultStyle: true,
                                    ),
                                  ),
                                  FancyText(
                                    text: "${contact[0].toString()}",
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FancyText(
                                text: "Department: ",
                                textAlign: TextAlign.left,
                                defaultStyle: true,
                              ),
                            ),
                            FancyText(
                                text: "$camelDepart",
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: FancyText(
                                text: "Sub-Department: ",
                                textAlign: TextAlign.left,
                                defaultStyle: true,
                              ),
                            ),
                            FancyText(
                                text: "$camelSub",
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    //width: 30.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0))),
                        elevation: 0.0,
                        color: Theme.of(context).colorScheme.primaryVariant,
                        textColor: Colors.white,
                        child: Icon(Icons.phone_forwarded),
                        onPressed: () {}),
                  ),
                )
              ],
            )
            // Text(),
            ),
      );
      //return ListView(children: contacts);
    }

    final cardView = doctorNames.map<Widget>(cardGenerator).toList();

    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "$department",
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView(children: cardView));
  }
}
