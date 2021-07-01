import 'dart:math';

import 'package:buddy/blocs/comment_bloc.dart';
import 'package:buddy/models/commentinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NewComment extends StatelessWidget {
  bool isReply;
  var replyinfo;
  var feedID;
  NewComment(this.isReply, this.replyinfo, this.feedID);
  final _controller = TextEditingController();
  var comment = CommentInfo();
  var bloc = CommentBloc();
  void sendComment() {
    print(feedID);
    if (isReply) {
      comment.action = "send";
      comment.isCommentReply = isReply;
      comment.commentID = replyinfo["commentID"];
      comment.text = _controller.text.trim();
      comment.senderName = "Yoo";
      comment.senderID = "aassd";
      comment.createdAt = DateFormat(
        'h:m a',
      ).format(DateTime.now()).toString();
      comment.timestamp = DateTime.now().toString();
      comment.commentreplyID =
          "${comment.timestamp}${comment.senderID}${comment.commentID}";
      if (comment.text != "") {
        bloc.eventSink.add(comment);
      }
    } else {
      comment.action = "send";
      comment.isCommentReply = isReply;
      comment.feedID = feedID;
      comment.text = _controller.text.trim();
      comment.senderName = "Yoo";
      comment.senderID = "aassd";
      comment.createdAt = DateFormat(
        'h:m a',
      ).format(DateTime.now()).toString();
      comment.timestamp = DateTime.now().toString();
      comment.commentID =
          "${comment.timestamp}${comment.senderID}${comment.feedID}";
      if (comment.text != "") {
        bloc.eventSink.add(comment);
      }
    }
    _controller.text = "";
  }

  bool textContent(TextEditingController con) {
    if (con.text == null) {
      print('null');
      return false;
    } else {
      print('succ');
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
          horizontal: ScreenUtil().setWidth(10)),
      width: ScreenUtil().setWidth(360),
      decoration: BoxDecoration(color: Colors.black87),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.emoji_emotions_rounded,
              color: Colors.white,
              size: ScreenUtil().setHeight(25),
            ),
            onPressed: () {},
          ),
          Container(
              width: ScreenUtil().setWidth(250),
              child: TextField(
                maxLines: null,
                controller: _controller,
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(16)),
                cursorColor: Colors.white,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    hintText: isReply ? "Reply..." : "Add a Comment ...",
                    hintStyle: TextStyle(
                        color: Colors.grey, fontSize: ScreenUtil().setSp(14)),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(10),
                        horizontal: ScreenUtil().setWidth(10)),
                    focusColor: Colors.black,
                    border: InputBorder.none),
              )),
          IconButton(
              icon: Icon(
                Icons.send_rounded,
                color: textContent(_controller) ? Colors.white : Colors.grey,
                size: ScreenUtil().setHeight(25),
              ),
              onPressed: textContent(_controller) ? sendComment : null),
        ],
      ),
    );
  }
}
