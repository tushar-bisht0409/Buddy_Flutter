import 'package:buddy/screens/personchatscreen.dart';
import 'package:buddy/widgets/feedpost.dart';
import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  List<Color> tbcolor = [
    acolor.primary,
    Colors.black26,
    Colors.black26,
    Colors.black26,
  ];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.index == 0) {
        tbcolor = [
          acolor.primary,
          Colors.black26,
          Colors.black26,
          Colors.black26,
        ];
      } else if (_tabController.index == 1) {
        tbcolor = [
          Colors.black26,
          acolor.primary,
          Colors.black26,
          Colors.black26,
        ];
      } else if (_tabController.index == 2) {
        tbcolor = [
          Colors.black26,
          Colors.black26,
          acolor.primary,
          Colors.black26,
        ];
      } else {
        tbcolor = [
          Colors.black26,
          Colors.black26,
          Colors.black26,
          acolor.primary,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TabBar tb = TabBar(
      controller: _tabController,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.zero,
      indicatorColor: acolor.primary,
      unselectedLabelColor: Colors.grey,
      //  isScrollable: true,
      tabs: [
        Tab(
          child: Text(
            'Following',
            style:
                TextStyle(color: tbcolor[0], fontSize: ScreenUtil().setSp(12)),
          ),
        ),
        Tab(
          child: Text(
            'Academia',
            style:
                TextStyle(color: tbcolor[1], fontSize: ScreenUtil().setSp(12)),
          ),
        ),
        Tab(
          child: Text(
            'World',
            style:
                TextStyle(color: tbcolor[2], fontSize: ScreenUtil().setSp(12)),
          ),
        ),
      ],
    );
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(0),
            horizontal: ScreenUtil().setWidth(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: ScreenUtil().setHeight(30),
              child: Image.asset('lib/assets/images/buddy.png'),
            ),
            IconButton(
                icon: Icon(
                  Icons.chat_bubble_rounded,
                  color: Colors.black,
                  size: ScreenUtil().setHeight(20),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(PersonChatScreen.routeName);
                })
          ],
        ),
      ),
      DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(360),
                      decoration: BoxDecoration(color: Colors.white),
                      child: tb,
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          // bottom: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(5),
                          right: ScreenUtil().setWidth(5)),
                    ),
                    Container(
                      height: 1,
                      width: ScreenUtil().setWidth(360),
                      color: Colors.grey[200],
                    ),
                    Container(
                        color: Colors.white,
                        //     width: ScreenUtil().setWidth(340),
                        height: ScreenUtil().setHeight(690) -
                            tb.preferredSize.height -
                            toppad -
                            bottompad -
                            ScreenUtil().setWidth(30) -
                            ScreenUtil().setHeight(20) -
                            ScreenUtil().setHeight(10),
                        child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              FeedPost("Following"),
                              FeedPost("Academia"),
                              FeedPost("World"),
                            ])),
                  ]))),
    ]);
  }
}
