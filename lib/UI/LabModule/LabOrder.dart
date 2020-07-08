import 'package:chitwan_hospital/UI/LabModule/LabModule.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/Indicator.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/lab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LabOrder extends StatefulWidget {
  LabOrder({Key key}) : super(key: key);

  @override
  _LabOrderState createState() => _LabOrderState();
}

class _LabOrderState extends State<LabOrder> {
  String name;
  List search;
  Map orderData;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labDataStore = Provider.of<LabDataStore>(context);

    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: 'Create Order',
              titleColor: textDark,
            ),
            preferredSize: Size.fromHeight(40.0)),
        backgroundColor: theme.colorScheme.background,
        persistentFooterButtons: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: RaisedButton(
                color: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: FancyText(
                  text: "SUBMIT",
                  size: 16.0,
                  color: textDark_Yellow,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: orderData != null && !isActive
                    ? () {
                        print('updating');
                        print(orderData);
                        setState(() {
                          isActive = true;
                        });
                        labDataStore.createOrder(orderData).then((value) {
                          setState(() {
                            isActive = false;
                          });
                          print(value);
                          if (value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LabModule()),
                                (Route<dynamic> route) => false);
                          }
                        });
                        // pharmacyDataStore.setOrderRemark(widget.id, _remark);
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PharmacyModule()),
                        //     (Route<dynamic> route) => false);
                      }
                    : null,
              ),
            ),
          ),
        ],
        body: ListView(
          children: <Widget>[
            BoolIndicator(isActive),
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              //phone number
              padding: const EdgeInsets.all(10.0),
              child: FForms(
                icon: Icon(
                  Icons.people,
                  color: theme.iconTheme.color,
                ),
                text: "Patient Name",
                type: TextInputType.text,
                //width: width * 0.80,
                borderColor: theme.colorScheme.primary,
                formColor: Colors.white,
                textColor: blueGrey.withOpacity(0.7),
                validator: (val) =>
                    val.isEmpty || val.length < 8 ? 'Name is required' : null,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            FlatButton(
              // color: theme.primaryColor,
              onPressed: name != null && name.length > 8
                  ? () {
                      setState(() {
                        orderData = null;
                      });
                      if (name.length > 8)
                        labDataStore.getUserInfo(name).listen((event) {
                          final data = event.documents.map((e) {
                            final ret = e.data;
                            ret['id'] = e.documentID;
                            return ret;
                          }).toList();
                          if (data != null && data.length > 0) {
                            setState(() {
                              search = data;
                            });
                          }
                        });
                    }
                  : null,
              child: Row(
                children: <Widget>[
                  Text(
                    'Find User ',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: name != null && name.length > 8
                            ? theme.primaryColor
                            : theme.disabledColor),
                  ),
                  Icon(
                    Icons.search,
                    color: name != null && name.length > 8
                        ? theme.primaryColor
                        : theme.disabledColor,
                  )
                ],
              ),
            ),
            orderData == null && search != null && search.length > 0
                ? Column(
                    children: search
                        .map<Widget>(
                          (e) => InkWell(
                            onTap: () {
                              setState(() {
                                orderData = {
                                  'name': e['name'],
                                  'email': e['email'],
                                  'phone': e['phone'],
                                  'uid': e['id'],
                                };
                              });
                            },
                            // canRequestFocus: true,

                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white60,
                                        //offset: Offset(-4, -4),
                                        blurRadius: 3.0,
                                        spreadRadius: -12.0),
                                    BoxShadow(
                                        color: Colors.white60,
                                        offset: Offset(-4, -4),
                                        blurRadius: 3.0),
                                    BoxShadow(
                                        color: Colors.white60,
                                        offset: Offset(-4, -4),
                                        blurRadius: 3.0),
                                    BoxShadow(
                                      color: Color(0xffffffff),
                                      offset: Offset(-.9, -.9),
                                    ),
                                    BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.3),
                                        offset: Offset(4, 4),
                                        blurRadius: 3.0),
                                    BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.3),
                                        offset: Offset(.9, .9),
                                        blurRadius: 1.0),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width * 0.95,
                                height: 160.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              theme.colorScheme.background,
                                          backgroundImage: ExactAssetImage(
                                              "assets/images/doctor.png"),
                                          maxRadius: 45.0,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 3,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              FancyText(
                                                text: e['name'],
                                                fontWeight: FontWeight.w700,
                                                size: 15.5,
                                                textAlign: TextAlign.left,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0),
                                                child: FancyText(
                                                    text: e['email'],
                                                    textAlign: TextAlign.left,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5.0, bottom: 8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.phone,
                                                      size: 16.0,
                                                      color: theme
                                                          .colorScheme.primary,
                                                    ),
                                                    FancyText(
                                                      text: '  ' + e['phone'],
                                                      textAlign: TextAlign.left,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                        )
                        .toList(),
                  )
                : orderData != null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white60,
                                //offset: Offset(-4, -4),
                                blurRadius: 3.0,
                                spreadRadius: -12.0),
                            BoxShadow(
                                color: Colors.white60,
                                offset: Offset(-4, -4),
                                blurRadius: 3.0),
                            BoxShadow(
                                color: Colors.white60,
                                offset: Offset(-4, -4),
                                blurRadius: 3.0),
                            BoxShadow(
                              color: Color(0xffffffff),
                              offset: Offset(-.9, -.9),
                            ),
                            BoxShadow(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.3),
                                offset: Offset(4, 4),
                                blurRadius: 3.0),
                            BoxShadow(
                                color:
                                    theme.colorScheme.primary.withOpacity(0.3),
                                offset: Offset(.9, .9),
                                blurRadius: 1.0),
                          ],
                        ),
                        width: MediaQuery.of(context).size.width * 0.95,
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
                                  backgroundImage: ExactAssetImage(
                                      "assets/images/doctor.png"),
                                  maxRadius: 45.0,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FancyText(
                                        text: orderData['name'],
                                        fontWeight: FontWeight.w700,
                                        size: 15.5,
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: FancyText(
                                            text: orderData['email'],
                                            textAlign: TextAlign.left,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.phone,
                                              size: 16.0,
                                              color: theme.colorScheme.primary,
                                            ),
                                            FancyText(
                                              text: '  ' + orderData['phone'],
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
                        )
                    : SizedBox.shrink()
          ],
        ));
  }
}
