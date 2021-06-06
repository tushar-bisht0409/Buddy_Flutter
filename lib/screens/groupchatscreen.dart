import 'package:buddy/main.dart';
import 'package:buddy/chats/messages.dart';
import 'package:buddy/chats/newmessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class GroupChatScreen extends StatefulWidget {
  static const routeName = '/group_chat';
  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  TabBar gtb = TabBar(
    indicator: BubbleTabIndicator(
      indicatorHeight: ScreenUtil().setHeight(25),
      insets: EdgeInsets.all(ScreenUtil().setHeight(5)),
      padding: EdgeInsets.all(ScreenUtil().setHeight(2)),
      tabBarIndicatorSize: TabBarIndicatorSize.label,
      indicatorColor: acolor.ternary,
      indicatorRadius: ScreenUtil().setHeight(20),
    ),
    indicatorWeight: 0,
    //  indicatorColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    isScrollable: true,
    tabs: [
      Tab(
          icon: Icon(
        Icons.notifications_active_rounded,
        size: ScreenUtil().setHeight(20),
        color: acolor.primary,
      )),
      Tab(
        icon: Icon(
          Icons.chat_bubble_rounded,
          color: acolor.primary,
        ),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.grey[200],
            body: SingleChildScrollView(
                child: Stack(children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20) + ScreenUtil().setWidth(40),
                  //  bottom: ScreenUtil().setHeight(10),
                  //    left: ScreenUtil().setWidth(10),
                  //  right: ScreenUtil().setWidth(10)
                ),
                child: DefaultTabController(
                    length: 2,
                    child: Container(
                        alignment: Alignment.topCenter,
                        //  decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.center,
                                  width: ScreenUtil().setWidth(360),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              ScreenUtil().setWidth(50)),
                                          bottomRight: Radius.circular(
                                              ScreenUtil().setWidth(50)))),
                                  child: gtb),
                              Container(
                                  color: Colors.grey[200],
                                  //     width: ScreenUtil().setWidth(340),
                                  height: ScreenUtil().setHeight(690) -
                                      ScreenUtil().setHeight(20) -
                                      ScreenUtil().setWidth(40) -
                                      toppad -
                                      bottompad -
                                      gtb.preferredSize.height,
                                  child: TabBarView(children: <Widget>[
                                    Center(
                                      child: Text('It\'s cloudy here'),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        //    Expanded(
                                        //          child: Messages('chatroomid'),
                                        //      ),
                                        NewMessage(),
                                      ],
                                    ),
                                  ])),
                            ]))),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: ScreenUtil().setHeight(690) - toppad - bottompad,
                child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.white,
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
                            Text('Group Name'),
                            IconButton(
                                icon: Icon(Icons.more_vert_rounded),
                                onPressed: () {})
                          ],
                        ))),
              ),
            ]))));
  }
}
