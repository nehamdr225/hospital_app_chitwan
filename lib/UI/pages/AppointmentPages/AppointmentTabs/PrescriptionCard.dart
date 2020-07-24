import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PrescriptionCard extends StatefulWidget {
  final id;
  PrescriptionCard({this.id});

  @override
  _PrescriptionCardState createState() => _PrescriptionCardState();
}

class _PrescriptionCardState extends State<PrescriptionCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final prescription = Provider.of<UserDataStore>(context)
        .prescriptions
        .firstWhere((element) => element.id == widget.id);
    final DateTime date = DateTime.parse(prescription.timestamp);
    print(date);
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
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_today,
                                  size: 16.0,
                                  color: theme.iconTheme.color,
                                ),
                                FancyText(
                                    defaultStyle: true,
                                    text:
                                        ' ${date.year}-${date.month}-${date.day}' ??
                                            ''),
                              ],
                            )),
                        FancyText(
                          text: prescription.pharmacyName,
                          fontWeight: FontWeight.w700,
                          size: 15.5,
                          textAlign: TextAlign.left,
                        ),
                        prescription.status == "ready"
                            ? Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: FancyText(
                                  text: "Your prescription is ready!",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
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
                          color: prescription.status != null &&
                                  prescription.status == "ready"
                              ? Colors.green.shade400
                              : theme.colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3.0),
                              bottomLeft: Radius.circular(3.0))),
                      child: Center(
                        child: FancyText(
                          text: prescription.status ?? 'Pending',
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
