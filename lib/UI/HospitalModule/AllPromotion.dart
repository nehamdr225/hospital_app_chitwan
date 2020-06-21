import 'package:chitwan_hospital/UI/HospitalModule/PromotionListCard.dart';
import 'package:flutter/material.dart';

class AllPromotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context);
    return  Padding(
              padding:
                  const EdgeInsets.only(top: 14.0, right: 10.0, left: 10.0),
              child: Container(
                  alignment: Alignment.center,
                  height: 120.0,
                  child: PromotionListCard()),
            );
  }
}
