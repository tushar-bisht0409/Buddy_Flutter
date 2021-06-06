import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedStory extends StatelessWidget {
  bool storystatus;
  FeedStory(this.storystatus);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: ScreenUtil().setHeight(10),
      ),
      Container(
        margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: storystatus == false
                          ? acolor.primary
                          : Colors.transparent,
                      width: ScreenUtil().setHeight(2)),
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(29)),
                ),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: ScreenUtil().setHeight(2),
                        ),
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(27))),
                    child: CircleAvatar(
                      radius: ScreenUtil().setHeight(25),
                      backgroundColor: Colors.black,
                    ))),
            Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
                child: Text(
                  'Name Yo',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10), color: Colors.black),
                ))
          ],
        ),
      )
    ]);
  }
}
