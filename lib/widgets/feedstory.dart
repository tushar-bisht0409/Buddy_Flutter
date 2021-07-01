import 'dart:io';

import 'package:buddy/blocs/story_bloc.dart';
import 'package:buddy/chats/attachments.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/storyinfo.dart';
import 'package:buddy/screens/camerscreen.dart';
import 'package:buddy/screens/storyscreen.dart';
import 'package:buddy/widgets/addstory.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedStory extends StatelessWidget {
  bool storystatus = false;
  StoryBloc storybloc = StoryBloc();
  StoryInfo story = StoryInfo();
  var storyBy = [];
  var creatorName;

  Widget addStory(BuildContext context) {
    return Column(children: <Widget>[
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
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                          height: ScreenUtil().setHeight(130),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setHeight(15)))),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(30),
                              right: ScreenUtil().setWidth(30),
                              bottom: ScreenUtil().setHeight(400)),
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20),
                              vertical: ScreenUtil().setHeight(20)),
                          child: ListView(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Add A Story :",
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(16),
                                          fontWeight: FontWeight.w600))),
                              SizedBox(height: ScreenUtil().setHeight(10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.camera_alt_rounded),
                                        iconSize: ScreenUtil().setHeight(30),
                                        color: Colors.lightBlue,
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      CameraScreen("Story")));
                                        }),
                                    Text("Camera")
                                  ]),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  Column(children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.insert_photo_rounded),
                                        iconSize: ScreenUtil().setHeight(30),
                                        color: Colors.lightGreen,
                                        onPressed: () async {
                                          FilePickerResult result;
                                          result = await FilePicker.platform
                                              .pickFiles(
                                                  allowMultiple: false,
                                                  allowCompression: true,
                                                  type: FileType.media);

                                          if (result != null) {
                                            File file =
                                                File(result.files.single.path);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        AddStory("image",
                                                            file.path)));
                                          }
                                        }),
                                    Text("Gallery")
                                  ]),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  Column(children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.edit_rounded),
                                        iconSize: ScreenUtil().setHeight(30),
                                        color: Colors.yellow[700],
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      AddStory("text", "")));
                                        }),
                                    Text("Text")
                                  ]),
                                ],
                              ),
                            ],
                          ));
                    });
              },
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: storybloc.storyInfoStream,
        builder: (ctx, snapshot) {
          story.action = "receive";
          story.getBy = "Following";
          story.following = ["sss", "ssa", "aa", "dd", "1"]; // Following List
          storybloc.eventSink.add(story);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
              children: <Widget>[
                addStory(context),
                Container(
                    alignment: Alignment.center,
                    width: ScreenUtil().setWidth(200),
                    child: Text("Loading...."))
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
                  for (int i = 0; i < storyinfo.length; i++) {
                    if (storyinfo[i]["creatorID"] == storyBy[index]) {
                      creatorName = storyinfo[i]["creatorName"];
                      break;
                    }
                  }
                  return index == 0
                      ? Row(children: <Widget>[
                          addStory(context),
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
                                          creatorName.length > 10
                                              ? "${creatorName.substring(0, 8)}..."
                                              : creatorName,
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
                                        creatorName.length > 10
                                            ? "${creatorName.substring(0, 10)}..."
                                            : creatorName,
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
            addStory(context),
            Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(200),
                child: Text("Woops! No Stories"))
          ]);
        });
  }
}
