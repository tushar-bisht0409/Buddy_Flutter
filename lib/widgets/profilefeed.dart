import 'package:buddy/blocs/feed_bloc.dart';
import 'package:buddy/blocs/like_bloc.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:buddy/screens/commentscreen.dart';
import 'package:buddy/widgets/feedpoll.dart';
import 'package:buddy/widgets/feedstory.dart';
import 'package:buddy/widgets/loadmedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileFeed extends StatefulWidget {
  @override
  _ProfileFeedState createState() => _ProfileFeedState();
}

class _ProfileFeedState extends State<ProfileFeed> {
  FeedBloc feedbloc = FeedBloc();
  LikeBloc likebloc = LikeBloc();
  FeedInfo feed = FeedInfo();
  FeedInfo like = FeedInfo();
  var type = "Following";
  var captionExpand = [];
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      StreamBuilder(
          stream: feedbloc.feedInfoStream,
          builder: (ctx, snapshot) {
            feed.action = "receive";
            feed.getType = type; //Following // World // Academia
            feed.following = ["12345678"]; // Following List (UserID only)
            feed.academia = "";
            feedbloc.eventSink.add(feed);
            var feedInfo;
            if (snapshot.hasData) {
              if (snapshot.data[1] == false) {
                return Text("No Post");
              }
              feedInfo = snapshot.data[0];
              while (captionExpand.length < feedInfo.length) {
                captionExpand.add(false);
              }
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: feedInfo.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                        elevation: 10,
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(10),
                            horizontal: ScreenUtil().setWidth(10)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenUtil().setHeight(20)))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(10),
                              horizontal: 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setHeight(20)))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: ScreenUtil().setWidth(10)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            child: //Column(children: <Widget>[
                                                Text(
                                              feedInfo[index]['creatorName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      ScreenUtil().setSp(14)),
                                            ),
                                          )
                                        ])),
                                        IconButton(
                                            icon: Icon(Icons.more_vert_rounded),
                                            onPressed: null)
                                      ])),
                              feedInfo[index]['poll']
                                  ? FeedPoll(
                                      feedInfo[index]['feedID'],
                                      feedInfo[index]['mediaCategory'],
                                      feedInfo[index]['caption'],
                                      feedInfo[index]['mediaPath'],
                                      feedInfo[index]['options'],
                                      feedInfo[index]['voters'],
                                      feedInfo[index]['endDate'],
                                      feedInfo[index]['endTime'],
                                      feedInfo[index]['endtimeStamp'],
                                    )
                                  : GestureDetector(
                                      child: Container(
                                          alignment: Alignment.center,
                                          height: ScreenUtil().setHeight(300),
                                          color: Colors.black,
                                          child: feedInfo[index]
                                                      ['mediaCategory'] ==
                                                  'text'
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: ScreenUtil()
                                                          .setWidth(10)),
                                                  child: Text(
                                                    feedInfo[index]['caption'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20)),
                                                  ))
                                              : LoadMedia(feedInfo[index]
                                                  ['mediaPath'])),
                                      onDoubleTap: () {
                                        if (mounted) {
                                          setState(() {
                                            if (feedInfo[index]['likes']
                                                    .contains("1") ==
                                                false) //(userID))
                                            {
                                              like.like = "true";
                                              like.feedID =
                                                  feedInfo[index]['feedID'];

                                              like.action = "feed";
                                              likebloc.eventSink.add(like);
                                            }
                                          });
                                        }
                                      },
                                    ),
                              feedInfo[index]['poll']
                                  ? SizedBox()
                                  : Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(10),
                                          left: ScreenUtil().setWidth(20),
                                          right: ScreenUtil().setWidth(10)),
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                '${feedInfo[index]['likes'].length} ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: feedInfo[index]['likes']
                                                              .length ==
                                                          1
                                                      ? "like"
                                                      : "likes",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(12),
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ]),
                                      ),
                                    ),
                              feedInfo[index]['poll']
                                  ? SizedBox()
                                  : feedInfo[index]['mediaCategory'] !=
                                              'text' &&
                                          feedInfo[index]['caption'] != "" &&
                                          feedInfo[index]['caption'] != null
                                      ? GestureDetector(
                                          child: Container(
                                              width: ScreenUtil().setWidth(340),
                                              padding: EdgeInsets.only(
                                                  left:
                                                      ScreenUtil().setWidth(20),
                                                  right: ScreenUtil()
                                                      .setWidth(10)),
                                              child: RichText(
                                                text: TextSpan(
                                                    text:
                                                        '${feedInfo[index]['creatorName']} ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: feedInfo[index][
                                                                          'caption']
                                                                      .length >
                                                                  30
                                                              ? captionExpand[
                                                                      index]
                                                                  ? " ${feedInfo[index]['caption']}"
                                                                  : " ${feedInfo[index]['caption'].substring(0, 30)}"
                                                              : " ${feedInfo[index]['caption']}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(12),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          )),
                                                      TextSpan(
                                                          text: feedInfo[index][
                                                                          'caption']
                                                                      .length >
                                                                  30
                                                              ? captionExpand[
                                                                      index]
                                                                  ? ""
                                                                  : "...More"
                                                              : "",
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(14),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ))
                                                    ]),
                                              )),
                                          onTap: () {
                                            setState(() {
                                              if (captionExpand[index]) {
                                                captionExpand[index] = false;
                                              } else {
                                                captionExpand[index] = true;
                                              }
                                            });
                                          },
                                        )
                                      : Container(),
                              feedInfo[index]['poll']
                                  ? SizedBox()
                                  : Container(
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          StreamBuilder(
                                              stream: feedbloc.feedInfoStream,
                                              builder: (ctx, snapshot) {
                                                return feedInfo[index]['likes']
                                                        .contains(
                                                            "1") //(userID)
                                                    ? IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .favorite_rounded,
                                                            color: Colors.red,
                                                            size: ScreenUtil()
                                                                .setHeight(25)),
                                                        onPressed: () {
                                                          setState(() {
                                                            like.like = "false";
                                                            like.feedID =
                                                                feedInfo[index]
                                                                    ['feedID'];
                                                            like.action =
                                                                "feed";
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
                                                                .setHeight(25)),
                                                        onPressed: () {
                                                          setState(() {
                                                            like.like = "true";
                                                            like.feedID =
                                                                feedInfo[index]
                                                                    ['feedID'];
                                                            like.action =
                                                                "feed";
                                                            likebloc.eventSink
                                                                .add(like);
                                                          });
                                                        });
                                              }),
                                          IconButton(
                                              icon: Icon(
                                                Icons.mode_comment_rounded,
                                                color: Colors.black,
                                                size:
                                                    ScreenUtil().setHeight(25),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            CommentScreen(
                                                                feedInfo[index][
                                                                    'feedID'])));
                                              }),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ));
                  });
            }
            return Container(
                height: ScreenUtil().setHeight(400),
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }),
      Padding(padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(65)))
    ]);
  }
}
