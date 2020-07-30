import 'package:eMed/UI/HospitalModule/HospitalInquiryCard.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InquiryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inquiries = Provider.of<HospitalDataStore>(context).inquiries;

    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: WhiteAppBar(
            titleColor: theme.colorScheme.primary,
            logo: false,
            settings: false,
            title: "Inquiries",
          ),
        ),
        body: ListView.builder(
          itemCount: inquiries != null ? inquiries.length : 0,
          itemBuilder: (context, index) => InquiryCardHospital(
            id: inquiries[index].id,
          ),
        ));
  }
}
