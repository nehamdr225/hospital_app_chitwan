import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/atoms/RowInput.dart';
import 'package:chitwan_hospital/UI/core/atoms/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class LabResults extends StatelessWidget {
  final String name;
  final String caption;
  final image;
  final String phone;
  final date;
  final time;

  LabResults(
      {this.name, this.caption, this.image, this.phone, this.date, this.time});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "Your lab result",
              titleColor: Theme.of(context).colorScheme.primary,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.background,
              download: true,
            ),
            preferredSize: Size.fromHeight(50.0)),
        body: Container(
            padding: EdgeInsets.all(14.0),
            color: Theme.of(context).colorScheme.background,
            child: ListView(children: <Widget>[
              SizedBox(height: 10.0,),
              FancyText(
                text: "CMC Labs",
                size: 17.0,
                fontWeight: FontWeight.w600,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 8.0),
                child: RowInput(
                  title: "Referred By: ",
                  caption: "Dr. Bharati Devi Sharma",
                  defaultStyle: false,
                  titleSize: 15.0,
                  capSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: RowInput(
                  title: "Date of examination: ",
                  caption: date,
                  defaultStyle: false,
                  titleSize: 15.0,
                  capSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: RowInput(
                  title: "Examined By: ",
                  caption: "Dr. Bharati Devi Sharma",
                  defaultStyle: false,
                  titleSize: 15.0,
                  capSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: RowInput(
                  title: "Patient Name: ",
                  caption: name,
                  defaultStyle: false,
                  titleSize: 15.0,
                  capSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: RowInput(
                  title: "Patient Contact: ",
                  caption: phone,
                  defaultStyle: false,
                  titleSize: 15.0,
                  capSize: 15.0,
                ),
              ),
              SizedBox(height: 35.0),
              Table(children: <TableRow>[
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                    child: FancyText(
                      text: "Test Name ",
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w800,
                      size: 15.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "Normal",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "Patient's Results",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                    child: FancyText(
                      text: "WBC ",
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w500,
                      size: 15.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "500 - 1000",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "1800",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                    child: FancyText(
                      text: "WBC ",
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w500,
                      size: 15.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "500 - 1000",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "1800",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8.0),
                    child: FancyText(
                      text: "WBC ",
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.w500,
                      size: 15.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "500 - 1000",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FancyText(
                      text: "1800",
                      textAlign: TextAlign.left,
                      size: 15.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ]),
              ]),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: FancyText(
                  text: "Dr. Bharati Devi Bhandari",
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w500,
                  size: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3.0, left: 8.0),
                child: FancyText(
                  text: "Chief Medical Examiner",
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  size: 13.5,
                ),
              )
            ])));
  }
}
