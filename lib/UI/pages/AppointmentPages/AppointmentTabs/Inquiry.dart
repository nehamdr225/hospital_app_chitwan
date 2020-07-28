import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'InquiryCard.dart';

class Inquiry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inquiries = Provider.of<UserDataStore>(context).inquiries;

    return ListView.builder(
        itemCount:
            inquiries != null && inquiries.length > 0 ? inquiries.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return InquiryCard(id: inquiries[index].id);
        });
  }
}
