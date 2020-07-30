import 'package:eMed/UI/PharmacyModule/BuyerDetail.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/models/PharmacyAppointment.dart';
import 'package:eMed/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PharmacyCard extends StatefulWidget {
  final id;

  PharmacyCard({this.id});

  @override
  _PharmacyCardState createState() => _PharmacyCardState();
}

class _PharmacyCardState extends State<PharmacyCard> {
  // Map userInfo;
  @override
  Widget build(BuildContext context) {
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final PharmacyAppointment order = pharmacyDataStore.getOneOrder(widget.id);
    final DateTime date = DateTime.parse(order.timestamp);
    // if (userInfo == null)
    //   pharmacyDataStore.getUserInfo(order.userId).then(
    //         (value) => setState(
    //           () {
    //             userInfo = value.data;
    //           },
    //         ),
    // );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BuyerDetail(
                  buyerName: order.name, buyerPhone: order.phone, id: order.id
                  // date: order['date'],
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
            width: size.width * 0.95,
            height: 160.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      backgroundImage:
                          ExactAssetImage("assets/images/doctor.png"),
                      maxRadius: 45.0,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
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
                                      ' ${date.year}-${date.month}-${date.day}',
                                ),
                              ],
                            ),
                          ),
                          FancyText(
                            text: order.name,
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (order.status != 'rejected')
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: FancyText(
                                    text: "Prescription: ",
                                    textAlign: TextAlign.left,
                                    defaultStyle: true,
                                  ),
                                ),
                              if (order.medicine != null &&
                                  order.image == null &&
                                  order.status != 'rejected')
                                Container(
                                  width: size.width * 0.40,
                                  padding: const EdgeInsets.only(
                                      top: 2.0, right: 6.0),
                                  child: FancyText(
                                      textOverflow: TextOverflow.ellipsis,
                                      text:
                                          order.medicine.replaceAll(';', ', '),
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500),
                                ),
                              if (order.status == 'rejected')
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: FancyText(
                                    text: "Rejection Remark: ",
                                    textAlign: TextAlign.left,
                                    // defaultStyle: true,
                                    color: Colors.red,
                                  ),
                                ),
                              if (order.status == 'rejected')
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: FancyText(
                                    textOverflow: TextOverflow.ellipsis,
                                    color: Colors.red,
                                    text: order.remark,
                                    textAlign: TextAlign.left,
                                    // defaultStyle: true,
                                  ),
                                ),
                              if (order.image != null &&
                                  order.medicine != null &&
                                  order.status != 'rejected')
                                Container(
                                  width: size.width * 0.40,
                                  padding: const EdgeInsets.only(
                                      top: 2.0, right: 6.0),
                                  child: FancyText(
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "Prescription & List",
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500),
                                ),
                              if (order.image != null &&
                                  order.medicine == null &&
                                  order.status != 'rejected')
                                Container(
                                  width: size.width * 0.40,
                                  padding: const EdgeInsets.only(
                                      top: 2.0, right: 6.0),
                                  child: FancyText(
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "Prescription available",
                                      textAlign: TextAlign.left,
                                      fontWeight: FontWeight.w500),
                                ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(
                                    Icons.phone,
                                    size: 16.0,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                FancyText(
                                  text: order.phone,
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
                ],
              ),
            )
            // Text(),
            ),
      ),
    );
  }
}
