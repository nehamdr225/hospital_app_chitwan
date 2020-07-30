import 'package:eMed/UI/core/atoms/Category.dart';
import 'package:eMed/UI/pages/Ambulance/AmbulanceTab.dart';
import 'package:eMed/UI/pages/Home/DoctorsTab.dart';
import 'package:eMed/UI/pages/Hospital/HospitalTab.dart';
import 'package:eMed/UI/pages/Lab/LabTab.dart';
import 'package:eMed/UI/pages/Pharmacy/PharmacyTab.dart';
import 'package:flutter/material.dart';
import 'FancyText.dart';

class HorizontalList extends StatefulWidget {
  final listViews;
  final border;
  final scrollDirection;

  HorizontalList({
    this.listViews,
    this.border: false,
    this.scrollDirection: Axis.horizontal,
  });

  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    // final BloodRequest newRequest =
    //     BloodRequest(null, null, null, null, null, null, null);
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      itemCount: widget.listViews.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Category(
            name: widget.listViews[index]['name'],
            caption: widget.listViews[index]['name'],
            src: widget.listViews[index]['src'],
            height: 60.0,
            width: 50.0,
            containerWidth: 110.0,
            onTap: () {
              if (widget.listViews[index]['id'] == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DoctorsTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PharmacyTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AmbulanceTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LabTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 4) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HospitalTab(),
                  ),
                );
              } else if (widget.listViews[index]['id'] == 5) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: FancyText(
                              text: "Coming Soon!",
                              size: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    });

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => BloodBankForm(
                //       bloodRequestForm: newRequest,
                //     ),
                //   ),
                // );
              }
            },
          ),
        );
      }, //
    );
  }
}
