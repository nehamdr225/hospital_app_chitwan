import 'package:flutter/material.dart';

import 'InquiryCard.dart';

class Inquiry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return InquiryCard();
        });
  }
}