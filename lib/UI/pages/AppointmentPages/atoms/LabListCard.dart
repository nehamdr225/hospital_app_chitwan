import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/LabResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LabListCard extends StatefulWidget {
  final name;
  final image;
  final caption;
  final phone;
  final status;
  final date;
  final time;
  final take;
  final data;
  LabListCard(
      {this.image,
      this.name,
      this.caption,
      this.phone,
      this.date,
      this.status,
      this.time,
      this.take,
      this.data = false});

  @override
  _LabListCardState createState() => _LabListCardState();
}

class _LabListCardState extends State<LabListCard>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours % 60).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
  }

  timer(controller) {
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.status == "Ready"
            ? () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LabResults(
                          name: widget.name,
                          caption: widget.caption,
                          image: widget.image,
                          phone: widget.phone,
                          date: widget.date,
                          time: widget.time,
                        )));
              }
            : () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: FancyText(
                            text:
                                "Your results are being processed at the moment",
                            defaultStyle: true,
                            fontWeight: FontWeight.w700,
                            size: 17.0,
                            opacity: 1.0,
                          ),
                        ));
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
                          FancyText(
                            text: widget.name,
                            fontWeight: FontWeight.w700,
                            size: 15.5,
                            textAlign: TextAlign.left,
                          ),
                          RowInput(
                            title: "Tests: ",
                            caption: widget.caption,
                          ),
                          RowInput(
                            title: "Lab: ",
                            caption: "CMC Labs",
                          ),
                          Padding(
                              padding: EdgeInsets.all(0.0),
                              child: widget.data == true &&
                                      widget.status == "Ready"
                                  ? RowInput(
                                      title: "Physical Copy Collection ",
                                      caption: widget.date,
                                      capColor:
                                          theme.colorScheme.secondaryVariant,
                                      fontWeight: FontWeight.w700)
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
                                  text: "  ${widget.phone}",
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
                            color: widget.status == "Accepted" ||
                                    widget.status == "Ready"
                                ? Colors.green.shade400
                                : theme.colorScheme.secondary,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3.0),
                                bottomLeft: Radius.circular(3.0))),
                        child: Center(
                          child: FancyText(
                            text: widget.status,
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
