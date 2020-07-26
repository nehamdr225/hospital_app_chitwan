import 'package:chitwan_hospital/UI/HospitalModule/HospitalDetails.dart';
import 'package:chitwan_hospital/UI/LabModule/LabInfoUpload.dart';
import 'package:chitwan_hospital/UI/PharmacyModule/BuyerDetail.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/pages/Lab/LabDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LabratoryListCard extends StatefulWidget {
  final labName;
  final clientName;
  final labLocation;
  final image;
  final phone;
  final pharmacyStatus;
  final id;

  LabratoryListCard(
      {this.image = "assets/images/bakery.jpg",
      this.phone,
      this.clientName,
      this.labLocation,
      this.pharmacyStatus,
      this.labName,
      this.id});

  @override
  _LabratoryListCardState createState() => _LabratoryListCardState();
}

class _LabratoryListCardState extends State<LabratoryListCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (widget.clientName == null) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LabDetails(
                      labLocation: widget.labLocation,
                      labName: widget.labName,
                      phone: widget.phone,
                      image: widget.image,
                      status: widget.pharmacyStatus,
                    )));
          } else if (widget.id == 'Lab') {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LabInfoUpload()));
          } else if (widget.id == "Pharmacy") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BuyerDetail(
                      buyerName: widget.clientName,
                      buyerPhone: widget.phone,
                      status: 'undecided',
                      // buyerPrescriptionimage: widget.image,
                    )));
          } else if (widget.id == "Hospital") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HospitalDetails(
                      name: widget.clientName,
                      phone: widget.phone,
                    )));
          }
        },
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
                          FancyText(
                            text: widget.labName,
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
                                  text: "Location: ",
                                  textAlign: TextAlign.left,
                                  defaultStyle: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: FancyText(
                                    text: widget.labLocation,
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
                                Icon(
                                  Icons.phone,
                                  size: 16.0,
                                  color: theme.colorScheme.primary,
                                ),
                                FancyText(
                                  text: "  ${widget.phone}",
                                  textAlign: TextAlign.left,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          widget.clientName == null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                        text: "Open Hours: ",
                                        textAlign: TextAlign.left,
                                        defaultStyle: true,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                          text: "6:00 AM to 10:00 PM",
                                          textAlign: TextAlign.left,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
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
    );
  }
}
