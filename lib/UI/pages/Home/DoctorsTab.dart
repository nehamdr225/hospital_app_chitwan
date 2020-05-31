import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Home/DoctorTabOnTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DoctorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Departments",
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: Doctor_Tab.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CallList()));
                },
                child: Padding(
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
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Image.asset(Doctor_Tab[index]["src"])
                          // Icon(
                          //   Icons.local_hospital,
                          //   color: Colors.red,
                          // ),
                        ),
                        FancyText(
                          text: Doctor_Tab[index]["name"],//"department",
                          fontWeight: FontWeight.w700,
                          textAlign: TextAlign.left,
                          size: 15.5,
                        ),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
