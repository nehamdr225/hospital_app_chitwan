import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String createTimeFromTimeStamp(Timestamp time) {
  final date = time.toDate();
  if (date.hour > 12) return '${date.hour - 12}:${date.minute} PM';
  return '${date.hour}:${date.minute} AM';
}

class SearchList extends StatelessWidget {
  final profileImg;
  final name;
  final unRead;
  final messageText;
  final onTap;
  final time;
  SearchList(
      {this.profileImg,
      this.name,
      this.unRead,
      this.messageText,
      this.onTap,
      this.time});

  @override
  Widget build(BuildContext context) {
    // print(profileImg);
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 0.7),
          color: unRead == true ? blueGrey.withOpacity(0.2) : theme.background,
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0), //left: 8.0, top: 8.0, bottom: 8.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        height: 70.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                //backgroundImage: FileImage(_profileImg),//Image.file(_profileImg),
                backgroundColor: theme.background,
                foregroundColor: Colors.white,
                radius: 40.0,
                child: profileImg != null
                    ? Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(profileImg),
                                fit: BoxFit.cover)),
                        //child: Image.file(_profileImg)
                      )
                    : Text(
                        name != null
                            ? name.split(' ').reduce((a, b) {
                                return '${a[0]} ${b[0]}';
                              })
                            : '',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: theme.primary,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700),
                      ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 8.0),
                child: FancyText(
                  text: name,
                  fontWeight: FontWeight.w600,
                  size: 15.0,
                  textAlign: TextAlign.start,
                ),
              ),
            ]),
      ),
    );
  }
}
