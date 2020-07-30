import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/atoms/WhiteAppBar.dart';
import 'package:eMed/UI/pages/Home/DoctorTabOnTap.dart';
import 'package:eMed/service/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DoctorsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            child: WhiteAppBar(
              title: "All Departments",
              titleColor: Theme.of(context).colorScheme.primary,
            ),
            preferredSize: Size.fromHeight(50.0)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: FutureBuilder(
            future: contactFetcher(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                buttonGenerator(department) {
                  final Map departmentDoctors = snapshot.data[department];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CallList(
                                department: department,
                                //data: snapshot.data[department],
                                departmentDoctors: departmentDoctors,
                              )));
                    },
                    child: Padding(
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
                        height: 60.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.local_hospital,
                                color: Colors.red,
                              ),
                            ),
                            FancyText(
                              text: department,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.left,
                            ),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final departments = snapshot.data.keys.toList();
                final containerView =
                    departments.map<Widget>(buttonGenerator).toList();
                return ListView(children: containerView);
              } else if (snapshot.hasError) {
                Center(
                    child: FancyText(
                  text: "Error ${snapshot.data}",
                ));
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryVariant
                      .withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primaryVariant,
                  ),
                ),
              );
            }));
  }
}
