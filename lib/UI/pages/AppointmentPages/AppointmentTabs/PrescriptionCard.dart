import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
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
    // print("THIS IS THE STUFF: ${widget.name},${widget.caption}, ${widget.phone}");
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => AppointmentDetail(
        //             id: widget.id,
        //           )));
        // },
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
                                  child: FancyText(
                                    text: "Ready for pickup",
                                    textAlign: TextAlign.left,
                                    defaultStyle: true,
                                  ),
                                )
                              : widget.status != null &&
                                      widget.status == "rejected"
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: FancyText(
                                        text: "Your order was rejected",
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
                                        color:
                                            theme.colorScheme.secondaryVariant,
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
