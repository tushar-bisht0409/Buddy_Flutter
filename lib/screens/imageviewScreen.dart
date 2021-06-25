import 'dart:io';

import 'package:buddy/blocs/chat_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImageViewScreen extends StatelessWidget {
  static const routeName = '/image_view';
  ImageViewScreen({Key key, this.path}) : super(key: key);
  final String path;
  var chatbloc = ChatBloc();
  var mszobj = MessageInfo();
  final _controller = new TextEditingController();

  void _sendMessage() {
    mszobj.action = 'send';
    mszobj.chatID = '12';
    mszobj.senderName = "";
    mszobj.receiverID = '';
    mszobj.senderID = "1";
    mszobj.text = _controller.text;
    mszobj.status = 'unread';
    mszobj.category = "image";
    mszobj.mediaPath = path;
    mszobj.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    mszobj.timestamp = DateTime.now().toString();
    chatbloc.eventSink.add(mszobj);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Caption....",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        backgroundColor: acolor.primary,
                        child: IconButton(
                          icon: Icon(Icons.send_rounded),
                          color: Colors.white,
                          onPressed: () {
                            _sendMessage();
                            Navigator.of(context).pop();
                          },
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
