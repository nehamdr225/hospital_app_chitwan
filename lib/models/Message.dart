import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageModel {
  String sender;
  String time;
  String text;
}

class Message implements MessageModel {
  String sender;
  String time;
  String text;
  // final bool isLiked;
  // final bool unread;

  Message({
    this.sender,
    this.text,
    this.time,
  });

  Message.fromJson(json) {
    this.sender = json['sender'];
    this.time = convertFromTimeStamp(json['timestamp']);
    this.text = json['message'];
  }
}

String convertFromTimeStamp(Timestamp timestamp) =>
    timestamp.toDate().toIso8601String();
