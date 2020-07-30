import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AmbulanceListCard extends StatefulWidget {
  final driverName;
  final hospitalName;
  final hospitalLocation;
  final image;
  final phone;
  AmbulanceListCard(
      {this.image,
      this.phone,
      this.driverName,
      this.hospitalLocation,
      this.hospitalName});

  @override
  _AmbulanceListCardState createState() => _AmbulanceListCardState();
}

class _AmbulanceListCardState extends State<AmbulanceListCard> {

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw ' Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                  color: Colors.grey[300],
                  offset: Offset(3, 3),
                  blurRadius: 3.0),
              BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(.9, .9),
                  blurRadius: 1.0),
            ],
          ),
          width: size.width * 0.90,
          height: 150.0,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Image.asset(
                  'assets/images/doctor.png',
                  height: 100.0,
                  width: 70.0,
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
                        text: widget.hospitalName,
                        fontWeight: FontWeight.w700,
                        size: 15.0,
                        textAlign: TextAlign.left,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: FancyText(
                              text: "Ambulance Driver: ",
                              textAlign: TextAlign.left,
                              defaultStyle: true,
                            ),
                          ),
                          FancyText(
                            text: widget.driverName,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: FancyText(
                              text: "Contact: ",
                              textAlign: TextAlign.left,
                              defaultStyle: true,
                            ),
                          ),
                          FancyText(
                            text: widget.phone,
                            textAlign: TextAlign.left,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: SizedBox(
                  //width: 30.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3.0),
                              bottomLeft: Radius.circular(3.0))),
                      elevation: 0.0,
                      color: Theme.of(context).colorScheme.primaryVariant,
                      textColor: Colors.white,
                      child: Icon(Icons.phone_forwarded),
                      onPressed: () {
                        _makePhoneCall(('tel: ${widget.phone}'));
                      }),
                ),
              )
            ],
          )
          // Text(),
          ),
    );
  }
}
