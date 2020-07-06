import 'package:chitwan_hospital/UI/DoctorsModule/PatientDetail.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/BuyerDetail.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/state/pharmacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PListCard extends StatefulWidget {
  final id;
  PListCard({this.id});

  @override
  _PListCardState createState() => _PListCardState();
}

class _PListCardState extends State<PListCard> {
  Map userInfo;
  @override
  Widget build(BuildContext context) {
    final pharmacyDataStore = Provider.of<PharmacyDataStore>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final order = pharmacyDataStore.getOneOrder(widget.id);
    if (userInfo == null)
      pharmacyDataStore.getUserInfo(order['userId']).then(
            (value) => setState(
              () {
                userInfo = value.data;
              },
            ),
          );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BuyerDetail(
                    id: widget.id,
                    buyerName: userInfo != null ? userInfo['name'] : '',
                    buyerPhone: userInfo != null ? userInfo['phone'] : '',
                    status: order != null ? order['status'] : '',
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
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.background,
                      maxRadius: 35.0,
                      child: Image.asset(
                        "assets/images/addProfileImg.png",
                        height: 40.0,
                        width: 40.0,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FancyText(
                            text: userInfo == null
                                ? 'Loading...'
                                : userInfo['name'],
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          // RowInput(
                          //   title: "Date:  ",
                          //   caption: widget.date,
                          //   defaultStyle: true,
                          // ),
                          // RowInput(
                          //   title: "Time:  ",
                          //   caption: widget.time,
                          // ),
                          order['status'] == "rejected"
                              ? RowInput(
                                  title: "Reason:  ",
                                  caption: order['remark'],
                                  defaultStyle: true,
                                )
                              : SizedBox(
                                  height: 1.0,
                                ),
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
                                  text: userInfo == null
                                      ? 'Loading...'
                                      : userInfo['phone'],
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
