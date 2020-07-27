import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/InquiryDetail.dart';
import 'package:flutter/material.dart';

class InquiryCard extends StatefulWidget {
  @override
  _InquiryCardState createState() => _InquiryCardState();
}

class _InquiryCardState extends State<InquiryCard> {
  String status=""; 

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InquiryDetail()));
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
                          FancyText(
                            text: "Inquiry Title",
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          status == "ready"
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: FancyText(
                                    textOverflow: TextOverflow.ellipsis,
                                    text: "Hospital's answer",
                                    textAlign: TextAlign.left,
                                    defaultStyle: true,
                                  ),
                                )
                              : Padding(
                                  //processing
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: FancyText(
                                    textOverflow: TextOverflow.ellipsis,
                                    text: "Your Inquiry detail",
                                    textAlign: TextAlign.left,
                                    color: Colors.black45,
                                  ),
                                ),
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
                            color: status != null &&
                                    status == "ready"
                                ? Colors.green.shade400
                                : theme.colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0))),
                        child: Center(
                          child: FancyText(
                            text: status ?? 'Pending',
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