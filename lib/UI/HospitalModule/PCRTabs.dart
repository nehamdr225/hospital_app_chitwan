import 'package:chitwan_hospital/UI/HospitalModule/PCRAppointmentDetails.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:chitwan_hospital/state/hospital.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:flutter/cupertino.dart';

class PCRTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appointments = Provider.of<HospitalDataStore>(context).appointments;
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: PreferredSize(
          child: WhiteAppBar(
            titleColor: theme.primary,
            title: "PCR Test Request",
          ),
          preferredSize: Size.fromHeight(60.0)),
      backgroundColor: theme.background,
      body: ListView.builder(
        itemCount: appointments != null ? appointments.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PCRAppointmentDetails(
                  id: appointments[index].id,
                ),
              ),
            ),
            child: PCRCard(
              date: appointments[index].date,
              name: appointments[index].firstName +
                  ' ' +
                  appointments[index].lastName,
              phone: appointments[index].phoneNum,
              status: appointments[index].status,
            ),
          );
        },
      ),
    );
  }
}

class PCRCard extends StatefulWidget {
  final name;
  final phone;
  final status;
  final DateTime date;
  PCRCard({
    this.name,
    this.phone,
    this.date,
    this.status,
  });

  @override
  _PCRCardState createState() => _PCRCardState();
}

class _PCRCardState extends State<PCRCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
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
                          text: widget.name,
                          fontWeight: FontWeight.w700,
                          size: 15.5,
                          textAlign: TextAlign.left,
                        ),
                        RowInput(
                          title: "Date:  ",
                          caption: widget.date.toIso8601String().split('T')[0],
                          defaultStyle: true,
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
                                text: "  ${widget.phone}",
                                textAlign: TextAlign.left,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        RowInput(
                          title: "Status:  ",
                          caption: widget.status ?? 'Not Accepted',
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
    );
  }
}
