import 'dart:io';

import 'package:buddy/blocs/filebase64_bloc.dart';
import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaMessageBubble extends StatelessWidget {
  String msz;
  String createdAt;
  bool isMe;
  String mediaPath;
  String category;
  //File mediaFile;
  final mediabloc = FileBase64Bloc();

  MediaMessageBubble(
      this.msz, this.isMe, this.createdAt, this.category, this.mediaPath);
  @override
  Widget build(BuildContext context) {
    // mediabloc.eventSink.add("ea45db9992098463752a22bf5d39876e.jpg");
    return StreamBuilder(
        stream: mediabloc.base64Stream,
        builder: (ctx, snapshot) {
          mediabloc.eventSink.add(mediaPath);
          return Container(
            decoration: BoxDecoration(
              color: isMe ? acolor.secondary : acolor.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(ScreenUtil().setHeight(5)),
                bottomRight: Radius.circular(ScreenUtil().setHeight(5)),
                topLeft: !isMe
                    ? Radius.circular(0)
                    : Radius.circular(ScreenUtil().setHeight(5)),
                topRight: isMe
                    ? Radius.circular(0)
                    : Radius.circular(ScreenUtil().setHeight(5)),
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: ScreenUtil().setWidth(238),
                minWidth: ScreenUtil().setWidth(30)),
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(4),
              horizontal: ScreenUtil().setHeight(4),
            ),
            margin: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(8),
              horizontal: ScreenUtil().setWidth(16),
            ),
            child: Column(
              //  crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    color: Colors.black,
                    height: ScreenUtil().setHeight(250),
                    width: ScreenUtil().setWidth(230),
                    child: snapshot.hasData == false
                        ? Center(child: CircularProgressIndicator())
                        : Image.file(File(snapshot.data))),
                msz != ""
                    ? Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setHeight(5),
                            right: ScreenUtil().setHeight(5),
                            top: ScreenUtil().setHeight(2)),
                        alignment: Alignment.centerLeft,
                        width: ScreenUtil().setWidth(230),
                        child: Text(
                          msz,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(14),
                            color: isMe ? Colors.black : Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ))
                    : SizedBox(
                        height: ScreenUtil().setHeight(2),
                      ),
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setHeight(3)),
                    alignment: Alignment.centerRight,
                    width: ScreenUtil().setWidth(230),
                    child: Text(
                      createdAt,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(9),
                        color: Colors.grey[200],
                      ),
                      // textAlign: // isMe ? TextAlign.end :
                      //   TextAlign.start
                    ))
              ],
            ),
          );
        });
  }
}
