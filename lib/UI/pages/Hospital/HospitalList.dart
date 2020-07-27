import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/pages/Hospital/HospitalProfile.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalList extends StatelessWidget {
  final id;
  HospitalList({this.id});
  @override
  Widget build(BuildContext context) {
    final hospital = Provider.of<UserDataStore>(context)
        .hospitals
        .firstWhere((element) => element.uid == id);

    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HospitalProfile(
                  id: hospital.uid,
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
                text: hospital.name,
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
