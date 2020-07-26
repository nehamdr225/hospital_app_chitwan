import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/pages/Lab/LabratoryListCard.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LabTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userDataStore = Provider.of<UserDataStore>(context);
    final laboratories = userDataStore.laboratories;
    if (laboratories == null || laboratories.length == 0) {
      userDataStore.getLabs();
    }
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "Laboratories",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ListView.builder(
            itemCount: laboratories != null ? laboratories.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return LabratoryListCard(
                id: laboratories[index].uid,
              );
            }));
  }
}
