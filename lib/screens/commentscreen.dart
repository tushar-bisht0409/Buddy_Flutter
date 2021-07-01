import 'package:buddy/blocs/comment_bloc.dart';
import 'package:buddy/blocs/like_bloc.dart';
import 'package:buddy/comments/commentreply.dart';
import 'package:buddy/comments/newcomment.dart';
import 'package:buddy/models/commentinfo.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CommentScreen extends StatefulWidget {
  static const routeName = '/comments';
  String feedID;
  CommentScreen(this.feedID);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final commentbloc = CommentBloc();
  var commentinfo = CommentInfo();
  FeedInfo like = FeedInfo();
  LikeBloc likebloc = LikeBloc();
  var replySelect = [];
  bool isReply = false;
  int commIndex;
  var replyinfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                          size: ScreenUtil().setHeight(25),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(18)),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                StreamBuilder(
                    stream: commentbloc.commentInfoStream,
                    builder: (ctx, snapshot) {
                      commentinfo.feedID = widget.feedID;
                      commentinfo.action = 'receive';
                      commentinfo.isCommentReply = false;
                      commentbloc.eventSink.add(commentinfo);
                      if (snapshot.hasData) {
                        if (snapshot.data[1]) {
                          final comment = snapshot.data[0];
                          if (replySelect.isEmpty) {
                            for (int i = 0; i < comment.length; i++) {
                              replySelect.add(false);
                            }
                          }
                          while (replySelect.length < comment.length) {
                            replySelect.add(false);
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: comment.length,
                              itemBuilder: (ctx, index) {
                                var ts =
                                    DateTime.parse(comment[index]["timeStamp"]);
                                return Column(children: <Widget>[
                                  Container(
                                    color: replySelect[index]
                                        ? Colors.red[100]
                                        : Colors.white,
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(18),
                                        left: ScreenUtil().setWidth(20),
                                        right: ScreenUtil().setWidth(10),
                                        bottom: ScreenUtil().setHeight(7)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: ScreenUtil().setHeight(15),
                                          backgroundColor: Colors.black,
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(20),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                                width:
                                                    ScreenUtil().setWidth(200),
                                                child: RichText(
                                                  text: TextSpan(
                                                      text: comment[index]
                                                          ["senderName"],
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(14),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                "  ${comment[index]["text"]}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          13),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            )),
                                                      ]),
                                                )),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil()
                                                        .setHeight(10)),
                                                width:
                                                    ScreenUtil().setWidth(200),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      DateFormat('d MMMM')
                                                          .format(ts)
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
                                                      comment[index]["likes"]
                                                                  .length ==
                                                              1
                                                          ? "${comment[index]["likes"].length} like"
                                                          : "${comment[index]["likes"].length} likes",
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
                                                    GestureDetector(
                                                      child: Text(
                                                        "Reply",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12)),
                                                      ),
                                                      onTap: () {
                                                        if (mounted) {
                                                          setState(() {
                                                            if (isReply) {
                                                              replySelect[
                                                                      commIndex] =
                                                                  false;
                                                            }
                                                            commIndex = index;

                                                            if (replySelect[
                                                                index]) {
                                                              replySelect[
                                                                      index] =
                                                                  false;
                                                            } else {
                                                              replySelect[
                                                                  index] = true;
                                                              isReply = true;
                                                            }
                                                            replyinfo =
                                                                comment[index];
                                                          });
                                                        }
                                                      },
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          width: ScreenUtil().setWidth(20),
                                        ),
                                        comment[index]['likes']
                                                .contains("1") //(userID)
                                            ? IconButton(
                                                icon: Icon(
                                                    Icons.favorite_rounded,
                                                    color: Colors.red,
                                                    size: ScreenUtil()
                                                        .setHeight(15)),
                                                onPressed: () {
                                                  setState(() {
                                                    like.like = "false";
                                                    like.feedID = comment[index]
                                                        ['commentID'];
                                                    like.action = "comment";
                                                    likebloc.eventSink
                                                        .add(like);
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
                                                    like.feedID = comment[index]
                                                        ['commentID'];
                                                    like.action = "comment";
                                                    likebloc.eventSink
                                                        .add(like);
                                                  });
                                                })
                                      ],
                                    ),
                                  ),
                                  CommentReply(comment[index]["commentID"])
                                ]);
                              });
                        } else {
                          return Text("No Comments");
                        }
                      } else {
                        return Container(
                          alignment: Alignment.center,
                          height: ScreenUtil().setHeight(600),
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
            Positioned(
                bottom: 0,
                child: Column(
                  children: <Widget>[
                    isReply
                        ? GestureDetector(
                            child: Container(
                                padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10),
                                  bottom: ScreenUtil().setHeight(10),
                                ),
                                alignment: Alignment.center,
                                width: ScreenUtil().setWidth(360),
                                color: Colors.black87,
                                child: Text(
                                  "Tap here to cancel Reply",
                                  style: TextStyle(color: Colors.white),
                                )),
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  isReply = false;
                                  replySelect[commIndex] = false;
                                });
                              }
                            },
                          )
                        : SizedBox(),
                    NewComment(isReply, replyinfo, widget.feedID)
                  ],
                ))
          ],
        ));
  }
}
