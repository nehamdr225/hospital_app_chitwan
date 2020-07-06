import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PrescriptionCard extends StatefulWidget {
  final id;
  final medicine;
  final status;
  PrescriptionCard({this.id, this.medicine, this.status});

  @override
  _PrescriptionCardState createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<PrescriptionCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          height: 100.0,
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
                          text: widget.medicine,
                          fontWeight: FontWeight.w700,
                          size: 15.5,
                          textAlign: TextAlign.left,
                        ),
                        widget.status != null && widget.status == "ready"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: RowInput(
                                    title: "Pick-Up from: ",
                                    caption: "CMC Pharmacy",
                                    defaultStyle: true))
                            // ? Padding(
                            //     padding: const EdgeInsets.only(top: 3.0),
                            //     child: RowInput(
                            //         title: "Delivery on: ",
                            //         caption: "07-08-2020",//(MM-DD-YYYY)
                            //         defaultStyle: true),
                            //   )
                            : widget.status != null &&
                                    widget.status == "rejected"
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: RowInput(
                                      title: "Reason: ",
                                      caption: "Rejection Reason",
                                      defaultStyle: true
                                    )
                                  )
                                : Padding(
                                    //processing
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: FancyText(
                                      text: "Your order is processing!",
                                      textAlign: TextAlign.left,
                                      color: theme.colorScheme.secondaryVariant,
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
                          color: widget.status != null &&
                                      widget.status == "Accepted" ||
                                  widget.status == "Ready" ||
                                  widget.status == "ready"
                              ? Colors.green.shade400
                              : widget.status == "Rejected" ||
                                      widget.status == "rejected"
                                  ? theme.colorScheme.secondary
                                  : blueGrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3.0),
                              bottomLeft: Radius.circular(3.0))),
                      child: Center(
                        child: FancyText(
                          text: widget.status ?? 'Pending',
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
    );
  }
}
