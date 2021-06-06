import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SandCProfileScreen extends StatefulWidget {
  static const routeName = '/sandc_profile';
  @override
  _SandCProfileScreenState createState() => _SandCProfileScreenState();
}

class _SandCProfileScreenState extends State<SandCProfileScreen> {
  TabBar tb = TabBar(
    indicator: BubbleTabIndicator(
      indicatorHeight: ScreenUtil().setHeight(25),
      insets: EdgeInsets.all(ScreenUtil().setHeight(5)),
      padding: EdgeInsets.all(ScreenUtil().setHeight(2)),
      tabBarIndicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.black,
      indicatorRadius: ScreenUtil().setHeight(20),
    ),
    indicatorWeight: 0,
    //  indicatorColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    isScrollable: false,
    tabs: [
      Tab(
        child: Text(
          'Info',
          style:
              TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14)),
        ),
      ),
      Tab(
          child: Text(
        'Feeds',
        style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(14)),
      )),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: <Widget>[
            Card(
                margin: EdgeInsets.zero,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(ScreenUtil().setHeight(30)),
                      bottomRight: Radius.circular(ScreenUtil().setHeight(30))),
                ),
                child: Container(
                  height: ScreenUtil().setHeight(200),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        colorFilter:
                            ColorFilter.mode(Colors.black54, BlendMode.darken),
                        image: AssetImage(
                          'lib/assets/images/sandc.png',
                        )),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(20),
                            vertical: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            Container(
                                alignment: Alignment.center,
                                width: ScreenUtil().setWidth(200),
                                child: Text(
                                  'A for Apple',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(20)),
                                )),
                            IconButton(
                                icon: Icon(
                                  Icons.chat_bubble_rounded,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(40),
                            vertical: ScreenUtil().setHeight(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  '11M',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(20)),
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.w800,
                                      fontSize: ScreenUtil().setSp(16)),
                                )
                              ],
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            DefaultTabController(
                length: 2,
                child: Container(
                    color: Colors.white,
                    alignment: Alignment.topCenter,
                    //  decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              alignment: Alignment.center,
                              width: ScreenUtil().setWidth(360),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                  ),
                                  child: tb)),
                          Container(
                              color: Colors.white,
                              width: ScreenUtil().setWidth(360),
                              height: ScreenUtil().setHeight(690) -
                                  ScreenUtil().setHeight(20) -
                                  ScreenUtil().setWidth(40) -
                                  toppad -
                                  bottompad -
                                  tb.preferredSize.height,
                              child: TabBarView(children: <Widget>[
                                Center(
                                  child: Text('It\'s cloudy here'),
                                ),
                                Center(
                                  child: Text('It\'s cloudy here'),
                                ),
                              ])),
                        ]))),
          ])),
    );
  }
}
