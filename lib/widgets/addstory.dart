import 'dart:io';

import 'package:buddy/blocs/story_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/storyinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddStory extends StatefulWidget {
  String category;
  String mediaPath;

  AddStory(this.category, this.mediaPath);
  @override
  _AddStoryState createState() => _AddStoryState();
}

class _AddStoryState extends State<AddStory> {
  StoryBloc storybloc = StoryBloc();
  StoryInfo storyinfo = StoryInfo();

  void createStory() {
    storyinfo.action = 'send';
    storyinfo.storyID = '12';
    storyinfo.creatorName = "Joe";
    storyinfo.creatorID = "1";
    if (_controller.text != null) {
      storyinfo.caption = _controller.text;
    } else {
      storyinfo.caption = "";
    }
    storyinfo.category = widget.category;
    storyinfo.mediaPath = widget.mediaPath;
    storyinfo.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    storyinfo.timestamp = DateTime.now().toString();
    storybloc.eventSink.add(storyinfo);
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: storybloc.storyInfoStream,
            builder: (ctx, snapshot) {
              return Stack(alignment: Alignment.bottomRight, children: <Widget>[
                Container(
                    //  margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                    height: ScreenUtil().setHeight(690),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                  size: ScreenUtil().setHeight(25),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            Text(
                              "Add Story",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(18)),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                        widget.category == "text"
                            ? Container(
                                alignment: Alignment.center,
                                height: ScreenUtil().setHeight(625),
                                color: Colors.black,
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                    vertical: ScreenUtil().setHeight(20)),
                                child: TextField(
                                  controller: _controller,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(20)),
                                  cursorColor: Colors.white,
                                  cursorHeight: ScreenUtil().setHeight(40),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 23,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      focusColor: Colors.black,
                                      border: InputBorder.none),
                                ))
                            : Container(
                                width: ScreenUtil().setWidth(360),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(360),
                                      height: ScreenUtil().setHeight(625),
                                      child: Image.file(
                                        File(widget.mediaPath),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        color: Colors.black38,
                                        width: ScreenUtil().setWidth(360),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        child: TextFormField(
                                          controller: _controller,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(16),
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLength: 190,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Add Caption....",
                                              hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    ScreenUtil().setSp(16),
                                              ),
                                              suffixIcon: CircleAvatar(
                                                radius:
                                                    ScreenUtil().setHeight(22),
                                                backgroundColor: acolor.primary,
                                                child: IconButton(
                                                  icon:
                                                      Icon(Icons.check_rounded),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    createStory();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    )),
                widget.category == "text"
                    ? Padding(
                        padding: EdgeInsets.all(
                          ScreenUtil().setHeight(10),
                        ),
                        child: CircleAvatar(
                          radius: ScreenUtil().setHeight(22),
                          backgroundColor: acolor.primary,
                          child: IconButton(
                            icon: Icon(Icons.check_rounded),
                            color: Colors.white,
                            onPressed: () {
                              createStory();
                              Navigator.of(context).pop();
                            },
                          ),
                        ))
                    : SizedBox(),
              ]);
            }));
  }
}
