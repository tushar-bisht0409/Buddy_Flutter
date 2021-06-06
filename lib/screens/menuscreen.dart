import 'package:buddy/screens/sandcscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/menu';
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    width: ScreenUtil().setWidth(140),
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        bottom: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(10)),
                    child: Image.asset('lib/assets/images/buddy.png'),
                  ),
                  IconButton(
                      icon: Icon(Icons.chat_bubble_rounded), onPressed: () {}),
                ]),
            Card(
                elevation: 10,
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(30)),
                ),
                child: Container(
                    //     margin: EdgeInsets.symmetric(
                    //       horizontal: ScreenUtil().setWidth(20)),
                    width: ScreenUtil().setWidth(320),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(30)),
                        color: Colors.white),
                    child: Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(10),
                                bottom: ScreenUtil().setHeight(10),
                                left: ScreenUtil().setWidth(10),
                                right: ScreenUtil().setWidth(10)),
                            child: CircleAvatar(
                              child: Container(
                                height: ScreenUtil().setHeight(100),
                                width: ScreenUtil().setHeight(100),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(50)),
                                    //border: Border.all(
                                    //  color: Colors.white,
                                    //style: BorderStyle.solid,
                                    // width: 2.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/images/test.png'))),
                              ),
                              radius: ScreenUtil().setHeight(50),
                              backgroundColor: Colors.black,
                            )),
                        Container(
                          height: ScreenUtil().setHeight(100),
                          width: ScreenUtil().setWidth(320) -
                              ScreenUtil().setWidth(20) -
                              ScreenUtil().setHeight(100),
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              bottom: ScreenUtil().setHeight(10),
                              left: ScreenUtil().setWidth(10),
                              right: ScreenUtil().setWidth(10)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Adolf Hitler',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  '100+ Friends',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Tap to view more info',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(10),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ))),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(20),
                    vertical: ScreenUtil().setHeight(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(20)),
                          ),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                left: ScreenUtil().setWidth(10),
                                right: ScreenUtil().setWidth(10)),
                            height: ScreenUtil().setHeight(100),
                            width: ScreenUtil().setWidth(150),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(20)),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black54, BlendMode.darken),
                                    image: AssetImage(
                                      'lib/assets/images/books.png',
                                    ))),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Find Some',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(14)),
                                ),
                                Text(
                                  '   .....Books',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(20)),
                                ),
                              ],
                            ),
                          )),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(20)),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(20),
                                left: ScreenUtil().setWidth(10),
                                right: ScreenUtil().setWidth(10)),
                            height: ScreenUtil().setHeight(100),
                            width: ScreenUtil().setWidth(150),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(20)),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black54, BlendMode.darken),
                                    image: AssetImage(
                                      'lib/assets/images/sandc.png',
                                    ))),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'CLUBS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(20)),
                                ),
                                Text(
                                  'and',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(14)),
                                ),
                                Text(
                                  'SOCIETIES',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(20)),
                                ),
                              ],
                            ),
                          )),
                      onTap: () {
                        Navigator.of(context).pushNamed(SandCScreen.routeName);
                      },
                    )
                  ],
                )),
            GestureDetector(
              child: Card(
                  elevation: 10,
                  margin: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                      vertical: ScreenUtil().setHeight(10)),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setHeight(20)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(180),
                    width: ScreenUtil().setWidth(320),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(20)),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black54, BlendMode.darken),
                            image: AssetImage(
                              'lib/assets/images/contest.png',
                            ))),
                    child: Text(
                      'CONTEST',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(26)),
                    ),
                  )),
              onTap: () {},
            )
          ],
        ));
  }
}
