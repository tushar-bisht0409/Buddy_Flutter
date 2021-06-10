import 'package:buddy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMessageBubble extends StatelessWidget {
  String msz;
  String createdAt;
  bool isMe;
  TextMessageBubble(this.msz, this.isMe, this.createdAt);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMe ? acolor.secondary : acolor.primary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ScreenUtil().setHeight(20)),
          topRight: Radius.circular(ScreenUtil().setHeight(20)),
          bottomLeft: !isMe
              ? Radius.circular(0)
              : Radius.circular(ScreenUtil().setHeight(20)),
          bottomRight: isMe
              ? Radius.circular(0)
              : Radius.circular(ScreenUtil().setHeight(20)),
        ),
      ),
      constraints: BoxConstraints(
          maxWidth: ScreenUtil().setWidth(220),
          minWidth: ScreenUtil().setWidth(30)),
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(8),
        horizontal: ScreenUtil().setWidth(16),
      ),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(8),
        horizontal: ScreenUtil().setWidth(16),
      ),
      child: Column(
        // mainAxisAlignment:
        //     isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            //     isMe ?
            CrossAxisAlignment.end,
        // : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            msz,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: isMe ? Colors.black : Colors.white,
            ),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
          Text(
            createdAt,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(9),
              color: Colors.grey[200],
            ),
            // textAlign: // isMe ? TextAlign.end :
            //   TextAlign.start
          )
        ],
      ),
    );
  }
}
