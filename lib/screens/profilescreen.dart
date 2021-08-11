import 'package:buddy/main.dart';
import 'package:buddy/widgets/feedgrid.dart';
import 'package:buddy/widgets/feedpost.dart';
import 'package:buddy/widgets/profileinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  var isMe;
  ProfileScreen(this.isMe);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var tbcolor = [
    Colors.black,
    Colors.grey,
  ];
  bool isFollowed = true;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      if (_tabController.index == 0) {
        tbcolor = [
          Colors.black,
          Colors.grey,
        ];
      } else if (_tabController.index == 1) {
        tbcolor = [
          Colors.grey,
          Colors.black,
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
      indicatorColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      //  isScrollable: true,
      tabs: [
        Tab(
          child: Column(children: <Widget>[
            Icon(
              Icons.grid_view,
              size: 15.h,
              color: tbcolor[0],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Feeds',
              style: TextStyle(
                  color: tbcolor[0], fontSize: ScreenUtil().setSp(10)),
            )
          ]),
        ),
        Tab(
          child: Column(children: <Widget>[
            Icon(
              Icons.account_circle_rounded,
              size: 15.h,
              color: tbcolor[1],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Info',
              style: TextStyle(
                  color: tbcolor[1], fontSize: ScreenUtil().setSp(10)),
            )
          ]),
        ),
      ],
    );
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://i.pinimg.com/originals/30/65/55/3065553218ec7b0d422179eace63f7fe.jpg"),
                  fit: BoxFit.fill)),
          height: 690.h,
          width: 360.h,
        ),
        ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Container(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          iconSize: 25.h,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                      Text(
                        "My Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          iconSize: 25.h,
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.transparent,
                          ),
                          onPressed: null)
                    ],
                  )),
            ),
            Container(
              height: 690.h - 50.h - 20.h,
              width: 360.h,
              color: Colors.transparent,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Stack(children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 75.h,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(
                              left: 70.h + 40.w, bottom: 10.h, right: 20.w),
                          child: Text("Dew Asward",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w300,
                              )),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          //    height: 1000.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 0),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.h),
                                  topRight: Radius.circular(25.h))),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 40.h,
                                left: 50.w,
                                right: 50.w,
                                bottom: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Card(
                                  elevation: 2,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.h))),
                                  child: Container(
                                    height: 65.h,
                                    width: 70.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.h))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "0",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Feeds",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400))
                                        ]),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.h))),
                                  child: Container(
                                    height: 65.h,
                                    width: 70.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.h))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "500",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Followers",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400))
                                        ]),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.h))),
                                  child: Container(
                                    height: 65.h,
                                    width: 70.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.h))),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "500",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("Following",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400))
                                        ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        isFollowed
                            ? Container(
                                margin: EdgeInsets.zero,
                                width: 360.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.white, width: 0)),
                                alignment: Alignment.center,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0.w),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.h)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 7.h),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black87,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5.h)),
                                            child: Text(
                                              "Unfollow",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0.w),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.h)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 7.h),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black87,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5.h)),
                                            child: Text(
                                              "Message",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ]))
                            : Container(
                                margin: EdgeInsets.zero,
                                width: 360.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.white, width: 0)),
                                alignment: Alignment.center,
                                child: Card(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 100.w),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.h)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50.w, vertical: 7.h),
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius:
                                              BorderRadius.circular(5.h)),
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))),
                        DefaultTabController(
                            initialIndex: 0,
                            length: 2,
                            child: Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 0)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        width: ScreenUtil().setWidth(360),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: tb,
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(10),
                                            // bottom: ScreenUtil().setHeight(10),
                                            left: ScreenUtil().setWidth(5),
                                            right: ScreenUtil().setWidth(5)),
                                      ),
                                      Container(
                                          height: 950.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          child: TabBarView(
                                              //  physics:
                                              //    NeverScrollableScrollPhysics(),
                                              controller: _tabController,
                                              children: <Widget>[
                                                //  FeedGrid(),
                                                Text("data"),
                                                ProfileInfo(widget.isMe),
                                              ])),
                                    ])))
                      ],
                    ),
                    Positioned(
                        top: 75.h - 35.h,
                        left: 30.w,
                        child: Container(
                          height: 70.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2.h,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.h),
                              ),
                              color: Colors.black),
                        ))
                  ])
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
