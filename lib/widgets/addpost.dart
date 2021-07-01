import 'dart:io';

import 'package:buddy/blocs/feed_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:buddy/screens/camerscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  String mediaPath;
  String postType;
  AddPost(this.mediaPath, this.postType);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _controller = TextEditingController();
  final caption = TextEditingController();
  bool toAcademia = false;
  bool toWorld = false;
  FeedBloc feedbloc = FeedBloc();
  FeedInfo feedinfo = FeedInfo();
  void createPost() {
    feedinfo.action = 'send';
    feedinfo.feedID = '12';
    feedinfo.creatorName = "Joe";
    feedinfo.creatorID = "12345678";
    if (widget.postType == "text") {
      feedinfo.caption = _controller.text;
    } else {
      if (caption.text != null) {
        feedinfo.caption = caption.text;
      } else {
        feedinfo.caption = "";
      }
    }
    if (widget.mediaPath == "") {
      feedinfo.mediaCategory = "text";
    } else {
      feedinfo.mediaCategory = "image";
    }
    if (toWorld) {
      feedinfo.category = "World";
    } else {
      feedinfo.category = "";
    }
    if (toAcademia) {
      feedinfo.academia = "User Academia";
    } else {
      feedinfo.academia = "";
    }
    feedinfo.mediaPath = widget.mediaPath;
    feedinfo.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    feedinfo.timestamp = DateTime.now().toString();
    print(feedinfo.caption);
    feedbloc.eventSink.add(feedinfo);
  }

  void snackBar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Content Empty , Can't Post!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: feedbloc.feedInfoStream,
            builder: (ctx, snapshot) {
              return Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                  height: ScreenUtil().setHeight(690),
                  child: ListView(
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
                            "Add Post",
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
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: ScreenUtil().setHeight(300),
                            margin: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10),
                                horizontal: ScreenUtil().setWidth(10)),
                            color: Colors.black,
                            child: widget.mediaPath == ""
                                ? widget.postType == "text"
                                    ? TextField(
                                        controller: _controller,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(20)),
                                        cursorColor: Colors.white,
                                        cursorHeight:
                                            ScreenUtil().setHeight(30),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 10,
                                        maxLength: 280,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: ScreenUtil()
                                                        .setWidth(10)),
                                            focusColor: Colors.black,
                                            border: InputBorder.none),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Selct Option Type",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    ScreenUtil().setSp(18),
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(15),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: Icon(Icons
                                                        .camera_alt_rounded),
                                                    iconSize: ScreenUtil()
                                                        .setHeight(30),
                                                    color: Colors.lightBlue,
                                                    onPressed: () {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (builder) =>
                                                                  CameraScreen(
                                                                      "Post")));
                                                    }),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                )
                                              ]),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(30),
                                              ),
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: Icon(Icons
                                                        .insert_photo_rounded),
                                                    iconSize: ScreenUtil()
                                                        .setHeight(30),
                                                    color: Colors.lightGreen,
                                                    onPressed: () async {
                                                      FilePickerResult result;
                                                      result = await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                              allowMultiple:
                                                                  false,
                                                              allowCompression:
                                                                  true,
                                                              type: FileType
                                                                  .media);

                                                      if (result != null) {
                                                        File file = File(result
                                                            .files.single.path);
                                                        setState(() {
                                                          widget.mediaPath =
                                                              file.path;
                                                          widget.postType =
                                                              "image";
                                                        });
                                                      }
                                                    }),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                )
                                              ]),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(30),
                                              ),
                                              Column(children: <Widget>[
                                                IconButton(
                                                    icon: Icon(
                                                        Icons.edit_rounded),
                                                    iconSize: ScreenUtil()
                                                        .setHeight(30),
                                                    color: Colors.yellow[700],
                                                    onPressed: () {
                                                      setState(() {
                                                        widget.postType =
                                                            "text";
                                                      });
                                                    }),
                                                Text(
                                                  "Text",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12)),
                                                )
                                              ]),
                                            ],
                                          ),
                                        ],
                                      )
                                : Image.file(
                                    File(widget.mediaPath),
                                    fit: BoxFit.fitHeight,
                                  ),
                          ),
                          widget.postType == ""
                              ? SizedBox()
                              : Positioned(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(5)),
                                      child: IconButton(
                                          color: Colors.black,
                                          iconSize: ScreenUtil().setHeight(35),
                                          icon: Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget.mediaPath = "";
                                              widget.postType = "";
                                            });
                                          })))
                        ],
                      ),
                      widget.postType == "text"
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(20),
                                  vertical: ScreenUtil().setHeight(10)),
                              child: TextField(
                                cursorColor: acolor.primary,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                onSubmitted: (value) {},
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setHeight(20))),
                                        borderSide: BorderSide(
                                            color: acolor.primary, width: 0.5)),
                                    focusColor: acolor.primary,
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setHeight(20))),
                                        borderSide: BorderSide(
                                            color: acolor.primary, width: 0.5)),
                                    contentPadding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(5),
                                        bottom: ScreenUtil().setHeight(5),
                                        left: ScreenUtil().setWidth(20)),
                                    hintText: 'Caption...',
                                    hintStyle: TextStyle(color: Colors.grey)),
                                controller: caption,
                                style: TextStyle(color: Colors.black),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autocorrect: true,
                                enableSuggestions: true,
                              )),
                      Row(
                        children: <Widget>[
                          Container(
                              width: ScreenUtil().setWidth(270),
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(25),
                                right: ScreenUtil().setWidth(25),
                                top: ScreenUtil().setHeight(15),
                              ),
                              child: Text(
                                "Visible To All The People Of Your Institution?",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400),
                              )),
                          IconButton(
                              icon: toAcademia
                                  ? Icon(Icons.check_circle_rounded,
                                      color: Colors.lightGreen,
                                      size: ScreenUtil().setHeight(25))
                                  : Icon(Icons.radio_button_off_rounded,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(25)),
                              onPressed: () {
                                setState(() {
                                  if (toAcademia) {
                                    toAcademia = false;
                                  } else {
                                    toAcademia = true;
                                  }
                                });
                              })
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              width: ScreenUtil().setWidth(270),
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(25),
                                right: ScreenUtil().setWidth(25),
                                top: ScreenUtil().setHeight(15),
                              ),
                              child: Text(
                                "Visible To Everyone?",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w400),
                              )),
                          IconButton(
                              icon: toWorld
                                  ? Icon(Icons.check_circle_rounded,
                                      color: Colors.lightGreen,
                                      size: ScreenUtil().setHeight(25))
                                  : Icon(Icons.radio_button_off_rounded,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(25)),
                              onPressed: () {
                                setState(() {
                                  if (toWorld) {
                                    toWorld = false;
                                  } else {
                                    toWorld = true;
                                  }
                                });
                              }),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(50),
                          ),
                          child: CircleAvatar(
                            radius: ScreenUtil().setHeight(22),
                            backgroundColor: acolor.primary,
                            child: IconButton(
                              icon: Icon(Icons.check_rounded),
                              color: Colors.white,
                              onPressed: () {
                                if (widget.postType == "") {
                                  snackBar();
                                } else if (widget.postType == "text") {
                                  if (_controller.text == null) {
                                    snackBar();
                                  } else {
                                    if (_controller.text.trim() == "") {
                                      snackBar();
                                    } else {
                                      createPost();
                                      //        Navigator.of(context).pop();
                                      return;
                                    }
                                  }
                                } else {
                                  createPost();
                                  //    Navigator.of(context).pop();
                                }
                              },
                            ),
                          ))
                    ],
                  ));
            }));
  }
}
