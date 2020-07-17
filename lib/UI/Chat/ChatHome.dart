import 'package:chitwan_hospital/UI/Chat/ChatScreen.dart';
import 'package:chitwan_hospital/UI/Chat/MsgList.dart';
import 'package:chitwan_hospital/UI/Widget/Forms.dart';
import 'package:chitwan_hospital/UI/core/atoms/AppBarW.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/state/ChatModels/messageModel.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:chitwan_hospital/state/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHome extends StatefulWidget {
  final userType;
  ChatHome({this.userType = 'user'});
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  String loading;

  @override
  Widget build(BuildContext context) {
    var userDataStore;
    if (widget.userType == 'user')
      userDataStore = Provider.of<UserDataStore>(context);
    else
      userDataStore = Provider.of<DoctorDataStore>(context);

    final messages = userDataStore.messages;
    final theme = Theme.of(context).colorScheme;
    print(messages);
    return Scaffold(
      backgroundColor: theme.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBarW(
          backButtonColor: textDark_Yellow,
          title: "Messages",
        ),
      ),
      body: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            Container(height: 20.0, color: theme.primaryVariant),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  color: theme.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              height: 20.0,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
          child: SizedBox(
            height: 45.0,
            child: FForms(
              text: "Search",
              icon: Icon(
                Icons.search,
                color: blueGrey,
              ),

              //width: MediaQuery.of(context).size.width*0.90,
              borderColor: theme.primary.withOpacity(0.5),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 18.0, bottom: 8.0),
          child: FancyText(
            text: 'Recent',
            color: blueGrey.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
          ),
        ),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: messages != null && messages.length > 0
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MsgList(
                        name: chats[index].sender.name,
                        unRead: chats[index].unread,
                        profileImg: chats[index].sender.imageUrl,
                        messageText: chats[index].text,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userId: messages[index]['userId'],
                              doctorId: messages[index]['doctorId'],
                              docName: messages[index]['doctor'],
                            ),
                          ),
                        ),
                      );
                    }, //
                  )
                : Text('You have no conversations!'),
          ),
        )
      ]),
    );
  }
}
