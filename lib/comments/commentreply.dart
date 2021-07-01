import 'package:flutter/material.dart';
import 'package:buddy/blocs/comment_bloc.dart';
import 'package:buddy/blocs/like_bloc.dart';
import 'package:buddy/models/commentinfo.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommentReply extends StatefulWidget {
  String commentID;
  CommentReply(this.commentID);

  @override
  _CommentReplyState createState() => _CommentReplyState();
}

class _CommentReplyState extends State<CommentReply> {
  bool expand = false;
  var commentreply = CommentInfo();
  FeedInfo like = FeedInfo();
  LikeBloc likebloc = LikeBloc();
  final commentreplybloc = CommentBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: commentreplybloc.commentInfoStream,
        builder: (ctx, snap) {
          commentreply.commentID = widget.commentID;
          commentreply.action = 'receive';
          commentreply.isCommentReply = true;
          commentreplybloc.eventSink.add(commentreply);
          if (snap.hasData) {
            if (snap.data[1] == false) {
              return Container();
            }
            var replies = snap.data[0];
            return Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
              width: ScreenUtil().setWidth(360),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      expand ? "Hide Reply" : "View Reply",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(12)),
                    ),
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          if (expand) {
                            expand = false;
                          } else {
                            expand = true;
                          }
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  expand
                      ? ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          itemCount: replies.length,
                          itemBuilder: (ctx, idx) {
                            var replyts =
                                DateTime.parse(replies[idx]["timeStamp"]);
                            return Container(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(7),
                                    right: ScreenUtil().setWidth(10),
                                    bottom: ScreenUtil().setHeight(18)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: ScreenUtil().setHeight(13),
                                        backgroundColor: Colors.black,
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(20),
                                      ),
                                      Column(children: <Widget>[
                                        Container(
                                            width: ScreenUtil().setWidth(170),
                                            child: RichText(
                                              text: TextSpan(
                                                  text: replies[idx]
                                                      ["senderName"],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "  ${replies[idx]["text"]}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: ScreenUtil()
                                                              .setSp(13),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        )),
                                                  ]),
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(
                                                top:
                                                    ScreenUtil().setHeight(10)),
                                            width: ScreenUtil().setWidth(170),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  DateFormat('d MMMM')
                                                      .format(replyts)
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                ),
                                                SizedBox(
                                                    width: ScreenUtil()
                                                        .setWidth(20)),
                                                Text(
                                                  replies[idx]["likes"]
                                                              .length ==
                                                          1
                                                      ? "${replies[idx]["likes"].length} like"
                                                      : "${replies[idx]["likes"].length} likes",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                ),
                                              ],
                                            ))
                                      ]),
                                      replies[idx]['likes']
                                              .contains("1") //(userID)
                                          ? IconButton(
                                              icon: Icon(Icons.favorite_rounded,
                                                  color: Colors.red,
                                                  size: ScreenUtil()
                                                      .setHeight(15)),
                                              onPressed: () {
                                                setState(() {
                                                  like.like = "false";
                                                  like.feedID = replies[idx]
                                                      ['commentreplyID'];
                                                  like.action = "commentreply";
                                                  likebloc.eventSink.add(like);
                                                });
                                              })
                                          : IconButton(
                                              icon: Icon(
                                                  Icons
                                                      .favorite_outline_rounded,
                                                  color: Colors.black,
                                                  size: ScreenUtil()
                                                      .setHeight(15)),
                                              onPressed: () {
                                                setState(() {
                                                  like.like = "true";
                                                  like.feedID = replies[idx]
                                                      ['commentreplyID'];
                                                  like.action = "commentreply";
                                                  likebloc.eventSink.add(like);
                                                });
                                              })
                                    ]));
                          })
                      : Container()
                ],
              ),
            );
          }

          return Container();
        });
  }
}
