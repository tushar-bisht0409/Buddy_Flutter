import 'package:buddy/blocs/chat_bloc.dart';
import 'package:buddy/chats/attachments.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String chatroomid;
  final chatbloc = ChatBloc();
  final mszobj = MessageInfo();

  var ico = Icons.mic_rounded;

  Future<void> setchatlist(String txt) async {}

  Future<void> createchatroom() async {
    final a = 'senderid';
    final b = 'receiverid';
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      chatroomid = '$b\_$a';
    } else {
      chatroomid = '$a\_$b';
    }
  }

  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage(String mszbody) async {
    mszobj.action = 'send';
    mszobj.chatID = '12';
    mszobj.senderName = "";
    mszobj.receiverID = '';
    mszobj.senderID = userID;
    mszobj.text = mszbody;
    mszobj.status = 'unread';
    mszobj.category = "text";
    mszobj.mediaPath = "";
    mszobj.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    mszobj.timestamp = DateTime.now().toString();
    chatbloc.eventSink.add(mszobj);
  }

  @override
  Widget build(BuildContext context) {
    createchatroom();
    return StreamBuilder(
        stream: chatbloc.messageInfoStream,
        builder: (ctx, snapshot) {
          return Card(
              margin: EdgeInsets.zero,
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(30)),
                      topRight: Radius.circular(ScreenUtil().setWidth(30)))),
              child: Container(
                //  height: ScreenUtil().setWidth(40) + ScreenUtil().setHeight(20),
                width: ScreenUtil().setWidth(360),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ScreenUtil().setWidth(30)),
                        topRight: Radius.circular(ScreenUtil().setWidth(30)))),
                //  margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(20),
                    horizontal: ScreenUtil().setWidth(10)),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      //  color: Theme.of(context).primaryColor,
                      icon: Icon(
                        Icons.emoji_emotions_rounded,
                        size: ScreenUtil().setWidth(20),
                      ),
                      onPressed: () {
                        print("object");
                      },
                    ),
                    Container(
                      //height: ScreenUtil().setHeight(40),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(20)),
                        color: acolor.ternary,
                        shape: BoxShape.rectangle,
                      ),
                      // Row(children: <Widget>[
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(5),
                                bottom: ScreenUtil().setHeight(5),
                                left: ScreenUtil().setWidth(10)),
                            border: InputBorder.none,
                            hintText: 'Message...',
                            hintStyle: TextStyle(color: Colors.black38)),
                        controller: _controller,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                        enableSuggestions: true,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              ico = Icons.send_rounded;
                            } else if (value.length == 0) {
                              ico = Icons.mic_rounded;
                            }
                            _enteredMessage = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        ico,
                        size: ScreenUtil().setWidth(20),
                      ),
                      onPressed: () {
                        if (_enteredMessage.trim().isEmpty == false) {
                          ico = Icons.mic_rounded;
                          _sendMessage(_controller.text);
                          ico = Icons.mic_rounded;
                          _controller.text = '';
                        } else {}
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.attach_file_rounded,
                        size: ScreenUtil().setWidth(20),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return attachments(context);
                            });
                      },
                    ),
                  ],
                ),
              ));
        });
  }
}
