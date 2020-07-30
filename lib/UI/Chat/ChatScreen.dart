import 'package:eMed/UI/core/atoms/AppBarW.dart';
import 'package:eMed/UI/core/atoms/FancyText.dart';
import 'package:eMed/UI/core/theme.dart';
import 'package:eMed/models/Message.dart';
import 'package:eMed/state/doctor.dart';
import 'package:eMed/state/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final userId, doctorId, userType, docName, userName;
  ChatScreen(
      {this.userId,
      this.doctorId,
      this.userType = 'user',
      this.docName,
      this.userName});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String sendPayload;
  Map initialMessages;
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
        userDataStore.getSpecificMessages(widget.userId, widget.doctorId) ??
            initialMessages;

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
                onChanged: (value) =>
                    // print(value);
                    setState(() {
                  sendPayload = value;
                }),
              )),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: theme.primary.withOpacity(0.5),
                onPressed: () async {
                  final Map msgPayload = {
                    'message': sendPayload,
                    'timestamp': Timestamp.now(),
                    'sender': widget.userType == 'user'
                        ? widget.userId
                        : widget.doctorId,
                  };
                  controller.clear();
                  if (messages != null) {
                    userDataStore.pushMessageLocally(
                        msgPayload, messages['id']);
                    userDataStore.sendMessage(msgPayload, messages['id']);
                  }
                  if (messages == null) {
                    final data = await userDataStore.createMessageCollection(
                        widget.userType == 'user'
                            ? widget.doctorId
                            : widget.userId,
                        widget.userType == 'user'
                            ? widget.docName
                            : widget.userName);
                    final updated = data['conversations'].add(msgPayload);
                    userDataStore.pushMessageLocally(msgPayload, data['id']);
                    userDataStore.sendMessage(msgPayload, data['id']);
                    setState(() {
                      initialMessages = updated;
                    });
                  }
                },
              )
            ],
          ));
    }

    _buildMessage(Message message, bool isMe) {
      return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            alignment: isMe ? Alignment.bottomRight : Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: Container(
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
              child: FancyText(
                text: message.text,
                textAlign: TextAlign.left,
                size: 15.0,
                textOverflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      );
    }

    if (messages != null) userDataStore.listenToMessages(messages['id']);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.primaryVariant,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBarW(
            elevation: 0.0,
            backButtonColor: textDark_Yellow,
            title: widget.userType == 'user' ? widget.docName : widget.userName,
            settings: true,
            onPressed: () {
              Navigator.pop(context);
            },
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
                      // reverse: true,
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
                        final bool isMe = widget.userType == 'user'
                            ? message.sender == widget.userId
                            : message.sender == widget.doctorId;

                        return _buildMessage(message, isMe);
                      })),
            )),
            _buildMessageComposer()
          ]),
        ),
      ),
    );
  }
}
