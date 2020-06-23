import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/AppointmentTabs/AppointmentDetail.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ListCard extends StatefulWidget {
  final id;
  final data;
  ListCard({this.id, this.data = false});

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    // print("THIS IS THE STUFF: ${widget.name},${widget.caption}, ${widget.phone}");
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Map displayData = {};
    if (!widget.data)
      displayData =
          Provider.of<UserDataStore>(context).getOneAppointment(widget.id);
    final Timestamp date = displayData['date'] ?? Timestamp.now();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AppointmentDetail(
                    id: widget.id,
                  )));
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
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: widget.data == false
                                  ? Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16.0,
                                          color: theme.iconTheme.color,
                                        ),
                                        FancyText(
                                            defaultStyle: true,
                                            text:
                                                ' ${date.toDate().year}-${date.toDate().month}-${date.toDate().day}' ??
                                                    ''),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            Icons.timer,
                                            size: 16.0,
                                            color: theme.iconTheme.color,
                                          ),
                                        ),
                                        FancyText(
                                            defaultStyle: true,
                                            text: displayData["time"] ?? '')
                                      ],
                                    )
                                  : null),
                          FancyText(
                            text: displayData['doctor'] ?? '',
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                  text: "Department: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                    text: displayData['department'] ?? "",
                                    textAlign: TextAlign.left,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          widget.data == false
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                        text: "Hospital: ",
                                        textAlign: TextAlign.left,
                                        defaultStyle: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                          text: displayData['hospital'] ?? '',
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              : displayData['status'] ?? '' == "Ready"
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: FancyText(
                                            text: "Collect from: ",
                                            textAlign: TextAlign.left,
                                            defaultStyle: true,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 3.0),
                                          child: FancyText(
                                            text: displayData['take'] ?? "",
                                            textAlign: TextAlign.left,
                                            size: 14.5,
                                            fontWeight: FontWeight.w700,
                                            color: theme
                                                .colorScheme.secondaryVariant,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Padding(
                                      //processing
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                        text: "Your order is processing!",
                                        textAlign: TextAlign.left,
                                        color:
                                            theme.colorScheme.secondaryVariant,
                                      ),
                                    ),
                          Padding(
                              padding: EdgeInsets.all(0.0),
                              child: widget.data == true &&
                                      displayData['status'] != null &&
                                      displayData['status'] == "Ready"
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: FancyText(
                                            text: "Collect on: ",
                                            textAlign: TextAlign.left,
                                            defaultStyle: true,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: FancyText(
                                              text:
                                                  "${date.toDate()} at ${displayData['time']}",
                                              textAlign: TextAlign.left,
                                              size: 14.5,
                                              color: theme
                                                  .colorScheme.secondaryVariant,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    )
                                  : null),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  size: 16.0,
                                  color: theme.colorScheme.primary,
                                ),
                                FancyText(
                                  text: displayData["phoneNum"] ?? "",
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
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
                            color: displayData['status'] != null &&
                                        displayData['status'] == "Accepted" ||
                                    displayData['status'] == "Ready"
                                ? Colors.green.shade400
                                : theme.colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0))),
                        child: Center(
                          child: FancyText(
                            text: displayData['status'] ?? 'Pending',
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
