import 'package:buddy/blocs/story_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/storyinfo.dart';
import 'package:buddy/screens/storyscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedStory extends StatelessWidget {
  bool storystatus = false;
  StoryBloc storybloc = StoryBloc();
  StoryInfo story = StoryInfo();
  var storyBy = [];
  Widget addStory = Column(children: <Widget>[
    SizedBox(
      height: ScreenUtil().setHeight(10),
    ),
    Container(
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      child: Column(
        children: <Widget>[
          GestureDetector(
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
                  radius: ScreenUtil().setHeight(27),
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: ScreenUtil().setHeight(20),
                  ),
                )),
            onTap: () {},
          ),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
              child: Text(
                'Add Story',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(10), color: Colors.black),
              ))
        ],
      ),
    )
  ]);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: storybloc.storyInfoStream,
        builder: (ctx, snapshot) {
          story.action = "receive";
          story.getBy = "Following";
          story.following = ["sss", "ssa", "aa", "dd"]; // Following List
          storybloc.eventSink.add(story);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: <Widget>[
                addStory,
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
          final storyinfo = snapshot.data[0];
          if (snapshot.data[1] == true) {
            for (int i = 0; i < storyinfo.length; i++) {
              if (storyBy.contains(storyinfo[i]['creatorID']) == false) {
                storyBy.add(storyinfo[i]['creatorID']);
              }
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: storyBy.length,
                itemBuilder: (ctx, index) {
                  return index == 0
                      ? Row(children: <Widget>[
                          addStory,
                          Column(children: <Widget>[
                            SizedBox(
                              height: ScreenUtil().setHeight(10),
                            ),
                            GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: storyinfo[index]["seenBy"]
                                                      .contains('12')
                                                  ? Colors.transparent
                                                  : acolor.primary,
                                              width: ScreenUtil().setHeight(2)),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setHeight(29)),
                                        ),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width:
                                                      ScreenUtil().setHeight(2),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil()
                                                            .setHeight(27))),
                                            child: CircleAvatar(
                                              radius:
                                                  ScreenUtil().setHeight(25),
                                              backgroundColor: Colors.black,
                                            ))),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil().setHeight(3)),
                                        child: Text(
                                          storyinfo[index]['creatorName'],
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(10),
                                              color: Colors.black),
                                        ))
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => StoryScreen(
                                            storyinfo, storyBy, index)));
                              },
                            )
                          ])
                        ])
                      : Column(children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(20)),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: storyinfo[index]["seenBy"]
                                                    .contains('12')
                                                ? Colors.transparent
                                                : acolor.primary,
                                            width: ScreenUtil().setHeight(2)),
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setHeight(29)),
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.white,
                                                width:
                                                    ScreenUtil().setHeight(2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setHeight(27))),
                                          child: CircleAvatar(
                                            radius: ScreenUtil().setHeight(25),
                                            backgroundColor: Colors.black,
                                          ))),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(3)),
                                      child: Text(
                                        storyinfo[index]['creatorName'],
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(10),
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => StoryScreen(
                                          storyinfo, storyBy, index)));
                            },
                          )
                        ]);
                });
          }
          return Row(children: <Widget>[
            addStory,
            Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(200),
                child: Text("Woops! No Stories"))
          ]);
        });
  }
}
