import 'package:buddy/main.dart';
import 'package:buddy/chats/messages.dart';
import 'package:buddy/chats/newmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonChatScreen extends StatefulWidget {
  static const routeName = '/person_chat';
  @override
  _PersonChatScreenState createState() => _PersonChatScreenState();
}

class _PersonChatScreenState extends State<PersonChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setWidth(40) + ScreenUtil().setHeight(20),
                  //  bottom: ScreenUtil().setHeight(80)
                ),
                height:
                    ScreenUtil().setHeight(690) - ScreenUtil().setHeight(110),
                child: Messages('12')),
            NewMessage(),
          ],
        ),
        Positioned(
          top: 0,
          child: Container(
            width: ScreenUtil().setWidth(360),
            alignment: Alignment.topCenter,
            //height: ScreenUtil().setHeight(690) - toppad - bottompad,
            child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: acolor.primary,
                child: Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10),
                        right: ScreenUtil().setWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: ScreenUtil().setWidth(20),
                        ),
                        Text('Name'),
                        IconButton(
                            icon: Icon(Icons.more_vert_rounded),
                            onPressed: () {})
                      ],
                    ))),
          ),
        ),
        //     Positioned(
        //     bottom: 0,
        // child: NewMessage(),
        // )
      ]),
    ));
  }
}
