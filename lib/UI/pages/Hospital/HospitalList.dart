import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalProfile.dart';
import 'package:flutter/material.dart';

class HospitalList extends StatelessWidget {
  final hospitalName;
  HospitalList({this.hospitalName});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HospitalProfile(
              hospitalName: hospitalName,
            )));
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
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.red,
                ),
              ),
              FancyText(
                text: hospitalName,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.left,
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
