import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/UI/pages/Pharmacy/PharmacyListCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PharmacyTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Pharmacies",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: Pharmacy_List.length,
            itemBuilder: (BuildContext context, int index) {
              return PharmacyListCard(
                pharmacyName: Pharmacy_List[index]['name'],
                pharmacyLocation: Pharmacy_List[index]['location'],
                image: Pharmacy_List[index]['src'],
                phone: Pharmacy_List[index]['phone'],
              );
            })
       
        );
  }
}
