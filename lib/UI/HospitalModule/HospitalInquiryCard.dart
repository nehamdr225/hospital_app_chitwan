import 'package:eMed/UI/HospitalModule/HospitalInquiryDetail.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InquiryCardHospital extends StatelessWidget {
  final id;
  InquiryCardHospital({this.id});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final inquiry = Provider.of<HospitalDataStore>(context)
        .inquiries
        .firstWhere((element) => element.id == id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HospitalInquiryDetail(id: id)));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                    color: Colors.white60,
                    offset: Offset(-4, -4),
                    blurRadius: 3.0),
                BoxShadow(
                  color: Color(0xffffffff),
                  offset: Offset(-.9, -.9),
                ),
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(4, 4),
                    blurRadius: 3.0),
                BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    offset: Offset(.9, .9),
                    blurRadius: 1.0),
              ],
            ),
            width: size.width * 0.90,
            height: 150.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: FancyText(
                              text: inquiry.title,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w700,
                              size: 16,
                              textAlign: TextAlign.left,
                              color: theme.colorScheme.primaryVariant,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 20.0,
                                ),
                                SizedBox(width: 10.0),
                                FancyText(
                                  text: inquiry.phone,
                                  textOverflow: TextOverflow.ellipsis,
                                  size: 16,
                                  textAlign: TextAlign.left,
                                  color: theme.colorScheme.primaryVariant,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 20.0,
                              ),
                              SizedBox(width: 10.0),
                              FancyText(
                                textOverflow: TextOverflow.visible,
                                text: inquiry.inquiry,
                                textAlign: TextAlign.left,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    inquiry.answer != null
                                        ? Icons.check
                                        : Icons.cancel,
                                    size: 20.0,
                                  ),
                                  SizedBox(width: 10.0),
                                  FancyText(
                                    textOverflow: TextOverflow.visible,
                                    text: inquiry.answer ??
                                        'Inquiry is yet to be answered!',
                                    textAlign: TextAlign.left,
                                    color: inquiry.answer != null
                                        ? Colors.black87
                                        : Colors.red,
                                    // defaultStyle: true,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        width: 80.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: inquiry.answer != null
                                ? Colors.green.shade400
                                : theme.colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0))),
                        child: Center(
                          child: FancyText(
                            text:
                                inquiry.answer != null ? 'Answered' : 'Pending',
                            opacity: 0.5,
                            color: textDark_Yellow,
                          ),
                        ),
                      ))
                ],
              ),
            )
            // Text(),
            ),
      ),
    );
  }
}
