import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SandCgrid extends StatelessWidget {
  String name;
  String iurl;
  SandCgrid(this.name, this.iurl);
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(20)),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(10)),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(20)),
                ),
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                    vertical: ScreenUtil().setWidth(10)),
                child: Container(
                  height: ScreenUtil().setHeight(100),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setHeight(20)),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            iurl,
                          ))),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(5),
              ),
              child: Text(
                'Cricket Club',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                ScreenUtil().setWidth(5),
              ),
              child: Text(
                'Association : NIT',
                style: TextStyle(
                    color: Colors.black, fontSize: ScreenUtil().setSp(12)),
              ),
            )
          ],
        ));
  }
}
