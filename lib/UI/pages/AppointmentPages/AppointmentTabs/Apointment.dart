import 'package:chitwan_hospital/UI/pages/AppointmentPages/atoms/ListCard.dart';
import 'package:chitwan_hospital/UI/core/const.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:chitwan_hospital/service/auth.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final uid = Provider.of<AuthService>(context).getCurrentUID().toString();
    // return StreamBuilder(
    //   stream: Firestore.instance
    //       .collection("users")
    //       .document(uid)
    //       .collection("appointments")
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) return const Text("Loading");
    //     return ListView.builder(
    //         itemCount: snapshot.data.documents.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return ListCard(
    //             name: snapshot.data.documents[index]['doctor'],
    //             caption: snapshot.data.documents[index]['department'],
    //             //image: snapshot.data.documents[index]['src'],
    //             phone: snapshot.data.documents[index]['phone'],
    //             status: snapshot.data.documents[index]['status'],
    //             date: snapshot.data.documents[index]['date'],
    //             time: snapshot.data.documents[index]['time'],
    //           );
    //         });
    //   },
    // );

    //         .collection("users")
    //                     .document(uid)
    //                     .collection("appointments")
    //                     .add(widget.appointment.toJson());
    return ListView.builder(
          itemCount: NearYou.length,
          itemBuilder: (BuildContext context, int index) {
            return ListCard(
              name: NearYou[index]['name'],
              caption: NearYou[index]['cap'],
              image: NearYou[index]['src'],
              phone: NearYou[index]['phone'],
              status: NearYou[index]['status'],
              date: NearYou[index]['date'],
              time:NearYou[index]['time'],
            );
          },
    );
  }
}
