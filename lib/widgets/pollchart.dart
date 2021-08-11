import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PollChart extends StatelessWidget {
  var barHeight;
  var barTitle;
  var barPercent;
  PollChart(this.barHeight, this.barTitle);
  @override
  Widget build(BuildContext context) {
    if (barHeight != null && barHeight != "null") {
      barPercent = barHeight.toStringAsFixed(2);
    } else {
      barHeight = 0;
      barPercent = "0";
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      alignment: Alignment.bottomCenter,
      height: 120.h,
      child: Column(children: <Widget>[
        Text(
          "$barPercent%",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(3),
        ),
        Container(
          margin: EdgeInsets.only(top: (1 - barHeight / 100) * 100.h),
          height: (barHeight / 100) * 100.h,
          width: 10.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.h),
                topRight: Radius.circular(15.h)),
            color: acolor.secondary,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(3),
        ),
        Text(barTitle)
      ]),
    );
  }
}
