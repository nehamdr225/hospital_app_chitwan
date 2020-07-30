import 'package:eMed/UI/HospitalModule/PromotionListCard.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Promotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promotions = Provider.of<HospitalDataStore>(context)
        .promotions
        .where((element) => !element.isArchived)
        .toList();

    return ListView.builder(
      itemCount: promotions != null ? promotions.length : 0,
      itemBuilder: (context, index) {
        return PromotionListCard(id: promotions[index].id);
      },
    );
  }
}

class ArchivedPromotions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final promotions = Provider.of<HospitalDataStore>(context)
        .promotions
        .where((element) => element.isArchived)
        .toList();
    return ListView.builder(
      itemCount: promotions != null ? promotions.length : 0,
      itemBuilder: (context, index) {
        return PromotionListCard(id: promotions[index].id);
      },
    );
  }
}
