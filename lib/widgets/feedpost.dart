import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedPost extends StatefulWidget {
  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        margin: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(10),
            horizontal: ScreenUtil().setWidth(10)),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(ScreenUtil().setHeight(20)))),
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10), horizontal: 0),
          // height: ScreenUtil().setHeight(300),
          //width: ScreenUtil().setWidth(340),

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil().setHeight(20)))),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 0, horizontal: ScreenUtil().setWidth(10)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            child: Row(children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: ScreenUtil().setHeight(15),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(15),
                              ),
                              child: Column(children: <Widget>[
                                Text(
                                  'Yo Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(14)),
                                ),
                                Text(
                                  'Category',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey[700],
                                      fontSize: ScreenUtil().setSp(10)),
                                )
                              ]))
                        ])),
                        IconButton(
                            icon: Icon(Icons.more_vert_rounded),
                            onPressed: null)
                      ])),
              Container(
                height: ScreenUtil().setHeight(300),
                color: Colors.black,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: ScreenUtil().setWidth(10),
                    ),
                    IconButton(
                        icon: Icon(Icons.favorite,
                            color: Colors.black,
                            size: ScreenUtil().setHeight(25)),
                        onPressed: null),
                    IconButton(
                        icon: Icon(
                          Icons.comment_outlined,
                          color: Colors.black,
                          size: ScreenUtil().setHeight(25),
                        ),
                        onPressed: null),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
