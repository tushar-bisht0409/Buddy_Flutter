import 'dart:io';

import 'package:buddy/blocs/filebase64_bloc.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedGridContent extends StatelessWidget {
  var feedInfo;
  var index;
  FeedGridContent(this.feedInfo, this.index);
  FileBase64Bloc base64bloc = FileBase64Bloc();

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
          elevation: 2,
          margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.h))),
          child: feedInfo[index]["poll"]
              ? Container(
                  height: 65.h,
                  width: 70.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(25.h))),
                  child: Icon(
                    Icons.poll_rounded,
                    size: 80.h,
                    color: Colors.lightGreenAccent,
                  ),
                )
              : feedInfo[index]["mediaCategory"] == "text"
                  ? Container(
                      height: 65.h,
                      width: 70.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.h))),
                      child: Text(
                        (feedInfo[index]['caption'].length) > 205
                            ? " ${feedInfo[index]['caption'].substring(0, 205)}....."
                            : " ${feedInfo[index]['caption']}",
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ))
                  : StreamBuilder(
                      stream: base64bloc.base64Stream,
                      builder: (ctxx, snapShot) {
                        base64bloc.eventSink
                            .add([feedInfo[index]["mediaPath"], "Post"]);
                        if (snapShot.hasData) {
                          return Container(
                            height: 65.h,
                            width: 70.h,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.h)),
                                image: DecorationImage(
                                    image: FileImage(
                                      File(snapShot.data),
                                    ),
                                    fit: BoxFit.cover)),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      })),
      onTap: () {},
    );
  }
}
