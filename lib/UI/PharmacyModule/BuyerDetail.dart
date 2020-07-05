import 'package:chitwan_hospital/UI/PharmacyModule/PharmacyReady.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/PrescriptionView.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/RejectRemarkform.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class BuyerDetail extends StatefulWidget {
  final buyerName;
  // final buyerPrescriptionimage;
  final buyerPhone;
  final status;
  // final date;
  final time;
  final id;
  BuyerDetail(
      {
      // this.buyerPrescriptionimage,
      this.buyerName,
      this.buyerPhone,
      // this.date,
      this.status,
      this.time,
      this.id});

  @override
  _BuyerDetailState createState() => _BuyerDetailState();
}

class _BuyerDetailState extends State<BuyerDetail> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final order = pharmacyDataStore.getOneOrder(widget.id);

    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "Buyer History",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      floatingActionButton: order['status'] == "accepted"
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PharmacyReady(
                            // appointment: newAppointment,
                            )));
              },
              icon: Icon(
                Icons.calendar_today,
                color: textDark_Yellow,
              ),
              label: FancyText(
                text: "Mark Ready",
                color: textDark_Yellow,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: theme.primary,
            )
          : null,
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
          child: Center(
            child: Container(
                height: 180.0,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: gradientColor,
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
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(4, 4),
                        blurRadius: 3.0),
                    BoxShadow(
                        color: theme.primary.withOpacity(0.3),
                        offset: Offset(.9, .9),
                        blurRadius: 1.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: theme.background,
                            backgroundImage: ExactAssetImage(
                              'assets/images/doctor.png',
                            ),
                          )),
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FancyText(
                                text: widget.buyerName,
                                fontWeight: FontWeight.w700,
                                size: 15.5,
                                textAlign: TextAlign.left,
                                color: textDark_Yellow,
                              ),
                              // RowInput(
                              //   title: "Date:  ",
                              //   caption: '',
                              //   titleColor: textDark_Yellow,
                              //   capColor: textDark_Yellow,
                              //   defaultStyle: false,
                              // ),
                              RowInput(
                                title: "Phone Number:  ",
                                caption: widget.buyerPhone,
                                titleColor: textDark_Yellow,
                                capColor: textDark_Yellow,
                                defaultStyle: false,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FancyText(
                                      text: "Current Status: ",
                                      textAlign: TextAlign.left,
                                      color: textDark_Yellow,
                                    ),
                                    order['status'] == null
                                        ? Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.check_circle),
                                                color: Colors.green,
                                                onPressed: () {
                                                  pharmacyDataStore
                                                      .setOrderStatus(
                                                          order['id'],
                                                          'accepted');
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.cancel),
                                                color: Colors.red,
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: FancyText(
                                                              text:
                                                                  "Are you sure?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: blueGrey),
                                                          content: FancyText(
                                                              text:
                                                                  "Are you sure you want to reject buyer request?",
                                                              size: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: blueGrey),
                                                          actions: <Widget>[
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons.cancel,
                                                                  color: theme
                                                                      .secondary,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .check_circle,
                                                                  color: Colors
                                                                          .green[
                                                                      600],
                                                                ),
                                                                onPressed: () {
                                                                  pharmacyDataStore
                                                                      .setOrderStatus(
                                                                          order[
                                                                              'id'],
                                                                          'rejected');
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          RejectRemarkForm(
                                                                              id: order['id']),
                                                                    ),
                                                                  );
                                                                }),
                                                          ],
                                                        );
                                                      });
                                                },
                                              ),
                                              SizedBox(width: 10.0),
                                            ],
                                          )
                                        : order['status'] == "rejected"
                                            ? Row(children: [
                                                FancyText(
                                                  text: "Rejected",
                                                  color: theme.secondary,
                                                  fontWeight: FontWeight.w700,
                                                  size: 15.0,
                                                ),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: () {
                                                    pharmacyDataStore
                                                        .setOrderStatus(
                                                            order['id'], null);
                                                  },
                                                  child: FancyText(
                                                    text: "undo",
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.red[200],
                                                    color: Colors.red[200],
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ])
                                            : Row(
                                                children: <Widget>[
                                                  FancyText(
                                                    text: "Accepted",
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w700,
                                                    size: 15.0,
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  InkWell(
                                                    onTap: () {
                                                      pharmacyDataStore
                                                          .setOrderStatus(
                                                              order['id'],
                                                              null);
                                                    },
                                                    child: FancyText(
                                                      text: "undo",
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Colors.red[200],
                                                      color: Colors.red[200],
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                              order['status'] == 'rejected'
                                  ? RowInput(
                                      title: "Remark:  ",
                                      caption: order['remark'] ?? '',
                                      titleColor: textDark_Yellow,
                                      capColor: textDark_Yellow,
                                      defaultStyle: false,
                                    )
                                  : Text(''),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                // Text(),
                ),
          ),
        ),
        Container(
          height: size.height * 0.60,
          child: Timeline.builder(
              physics: ClampingScrollPhysics(),
              position: TimelinePosition.Left,
              itemCount: doodles.length,
              itemBuilder: centerTimelineBuilder),
        )
      ]),
    );
  }

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final textTheme = Theme.of(context).textTheme;
    final doodle = doodles[i];
    return TimelineModel(
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PrescriptionView(images: doodle.image)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Tap to view...",
                        style: TextStyle(
                            fontSize: 12.0, color: blueGrey.withOpacity(0.7)),
                      )),
                  Text(doodle.time, style: textTheme.caption),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    doodle.diagnosis,
                    style: textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      position: TimelineItemPosition.left,
      iconBackground: doodle.iconBackground,
    );
  }
}
