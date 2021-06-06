import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:buddy/main.dart';
import 'package:buddy/screens/sandcprofilescreen.dart';
import 'package:buddy/widgets/sandcgrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SandCScreen extends StatefulWidget {
  static const routeName = '/sandc';
  @override
  _SandCScreenState createState() => _SandCScreenState();
}

class _SandCScreenState extends State<SandCScreen> {
  TabBar tb = TabBar(
    indicator: BubbleTabIndicator(
      indicatorHeight: ScreenUtil().setHeight(15),
      insets: EdgeInsets.all(ScreenUtil().setHeight(5)),
      padding: EdgeInsets.all(ScreenUtil().setHeight(2)),
      tabBarIndicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.white30,
      indicatorRadius: ScreenUtil().setHeight(20),
    ),
    indicatorWeight: 0,
    //  indicatorColor: Colors.black,
    unselectedLabelColor: Colors.grey,
    //isScrollable: true,
    tabs: [
      Tab(
        child: Text(
          'All',
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(10)),
        ),
      ),
      Tab(
          child: Text(
        'Joined',
        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(10)),
      )),
      Tab(
        child: Text(
          'Created',
          style:
              TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(10)),
        ),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.zero,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ScreenUtil().setHeight(40)),
                  bottomRight: Radius.circular(ScreenUtil().setHeight(40))),
            ),
            child: Container(

                // height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter:
                          ColorFilter.mode(Colors.black54, BlendMode.darken),
                      image: AssetImage(
                        'lib/assets/images/bg.png',
                      )),
                ),
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(20),
                          vertical: ScreenUtil().setHeight(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'CLUBS',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                              Text(
                                '&',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(22)),
                              ),
                              Text(
                                'SOCIETIES',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                            ],
                          ),
                          Container(
                              height: ScreenUtil().setHeight(30),
                              width: ScreenUtil().setWidth(200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(20)),
                                color: Colors.white24,
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(5)),
                                      child: Icon(
                                        Icons.search_rounded,
                                        color: Colors.white,
                                        size: ScreenUtil().setHeight(20),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(5)),
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(12)),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      )),
                  DefaultTabController(
                      length: 3,
                      child: Container(
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
                                      Container(
                                          padding: EdgeInsets.only(bottom: 50),
                                          margin: EdgeInsets.zero,
                                          height: ScreenUtil().setHeight(690) -
                                              ScreenUtil().setHeight(60) -
                                              ScreenUtil().setSp(22) * 3,
                                          child: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.75,
                                                      crossAxisSpacing:
                                                          ScreenUtil()
                                                              .setWidth(20),
                                                      mainAxisSpacing:
                                                          ScreenUtil()
                                                              .setHeight(20),
                                                      crossAxisCount: 2),
                                              itemCount: 10,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  child: SandCgrid(
                                                      'Cricket Club',
                                                      'https://3.imimg.com/data3/BG/WH/MY-11375155/leather-criket-ball-500x500.jpg'),
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            SandCProfileScreen
                                                                .routeName);
                                                  },
                                                );
                                              }))
                                    ])),
                              ]))),
                ])),
          ),
        ],
      ),
    ));
  }
}
