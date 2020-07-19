import 'package:chitwan_hospital/UI/core/atoms/AppBarW.dart';
import 'package:chitwan_hospital/UI/core/atoms/FancyText.dart';
import 'package:chitwan_hospital/UI/core/theme.dart';
import 'package:chitwan_hospital/models/Message.dart';
import 'package:chitwan_hospital/state/doctor.dart';
import 'package:chitwan_hospital/state/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final userId, doctorId, userType, docName;
  ChatScreen(
      {this.userId, this.doctorId, this.userType = 'user', this.docName});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sendPayload;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    var userDataStore;
    if (widget.userType == 'user')
      userDataStore = Provider.of<UserDataStore>(context);
    else
      userDataStore = Provider.of<DoctorDataStore>(context);
    Map messages =
        userDataStore.getSpecificMessages(widget.userId, widget.doctorId);
    if (messages == null) {
      userDataStore.createMessageCollection(widget.doctorId, widget.docName);
    }
    // print(messages);
    _buildMessageComposer() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          height: 70.0,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.photo),
                iconSize: 25.0,
                color: theme.primary.withOpacity(0.5),
                onPressed: () {},
              ),
              Expanded(
                  child: TextField(
                controller: controller,
                textCapitalization: TextCapitalization.sentences,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send message...'),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    sendPayload = value;
                  });
                },
              )),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: theme.primary.withOpacity(0.5),
                onPressed: () {
                  userDataStore.sendMessage({
                    'message': sendPayload,
                    'timestamp': Timestamp.now(),
                    'sender': widget.userId,
                  }, messages['id']);
                  controller.clear();
                },
              )
            ],
          ));
    }

    _buildMessage(Message message, bool isMe, imageUrl, String name, myImg) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          isMe
              ? SizedBox.shrink()
              : CircleAvatar(
                  //backgroundImage: FileImage(_user.imageUrl),//Image.file(_user.imageUrl),
                  backgroundColor: theme.primary,
                  foregroundColor: Colors.white,
                  // radius: 10.0,
                  child: imageUrl != null
                      ? Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(imageUrl),
                                  fit: BoxFit.cover)),
                          //child: Image.file(_user.imageUrl)
                        )
                      : Text(
                          name.split(' ').reduce((a, b) {
                            return '${a[0]} ${b[0]}';
                          }),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: textDark_Yellow,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
                color: isMe ? theme.onBackground : blueGrey.withOpacity(0.4),
                borderRadius: isMe
                    ? BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0))
                    : BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            margin: isMe
                ? EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: MediaQuery.of(context).size.width * 0.20)
                : EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    right: MediaQuery.of(context).size.width * 0.20),
            child: FancyText(
              text: message.text,
              textAlign: TextAlign.left,
              size: 15.0,
              textOverflow: TextOverflow.visible,
            ),
          ),
          isMe
              ? CircleAvatar(
                  //backgroundImage: FileImage(_user.imageUrl),//Image.file(_user.imageUrl),
                  backgroundColor: theme.secondary,
                  foregroundColor: Colors.white,
                  // radius: 10.0,
                  child: myImg != null
                      ? Container(
                          height: 25.0,
                          width: 25.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(myImg), fit: BoxFit.cover)),
                          //child: Image.file(_user.myImg)
                        )
                      : Text(
                          name.split(' ').reduce((a, b) {
                            return '${a[0]} ${b[0]}';
                          }),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: textDark_Yellow,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                )
              : SizedBox.shrink(),
        ],
      );
    }

    userDataStore.listenToMessages(messages['id']);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.primaryVariant,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBarW(
            elevation: 0.0,
            backButtonColor: textDark_Yellow,
            title: userDataStore.user['name'],
            settings: true,
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(children: <Widget>[
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: theme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  )),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      itemCount: messages != null
                          ? messages['conversations'].length
                          : 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (messages == null ||
                            messages['conversations'].length == 0)
                          return Text(
                            'Start a conversation!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black54),
                          );

                        final Message message =
                            Message.fromJson(messages['conversations'][index]);
                        final bool isMe = message.sender == widget.userId;
                        final myImg = null; //currentUser.imageUrl;
                        final imageUrl = null; //widget.user.imageUrl;
                        final name = userDataStore.user['name'];
                        return _buildMessage(
                            message, isMe, imageUrl, name, myImg);
                      })),
            )),
            _buildMessageComposer()
          ]),
        ),
      ),
    );
  }
}
