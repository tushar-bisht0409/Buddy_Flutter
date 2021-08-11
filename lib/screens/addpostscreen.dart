import 'dart:io';

import 'package:buddy/blocs/feed_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:buddy/screens/camerscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add_post';
  String mediaPath;
  String postType;
  AddPostScreen(this.mediaPath, this.postType);
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _controller = TextEditingController();
  final caption = TextEditingController();
  DateTime endDate;
  TimeOfDay endTime;
  bool toAcademia = false;
  bool toWorld = false;
  bool poll = false;
  int optCount = 1;
  var options = [""];
  FeedBloc feedbloc = FeedBloc();
  FeedInfo feedinfo = FeedInfo();
  List<TextEditingController> contList = [new TextEditingController()];
  void createPost() {
    var optCode = " ^&2943#7&%84# ";
    for (int i = 0; i < contList.length; i++) {
      options.add(contList[i].text);
    }
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
    feedinfo.poll = poll;
    if (poll) {
      feedinfo.endDate = DateFormat('d MMMM, y').format(endDate).toString();
      feedinfo.endTime =
          "${endTime.hourOfPeriod}:${endTime.minute} ${endTime.period.toString().substring(10)}";
      feedinfo.endtimestamp = DateTime.utc(
        endDate.year,
        endDate.month,
        endDate.day,
        endTime.hour,
        endTime.minute,
      ).toString();
      for (int i = 0; i < options.length; i++) {
        if (i == options.length - 1) {
          feedinfo.options = "${feedinfo.options}${options[i]}";
        } else if (i == 0) {
          feedinfo.options = "${options[i]}";
        } else {
          feedinfo.options = "${feedinfo.options}${options[i]}$optCode";
        }
      }
    }
    feedinfo.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    feedinfo.timestamp = DateTime.now().toString();
    print(feedinfo.caption);
    feedbloc.eventSink.add(feedinfo);
  }

  void snackBar(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print(options);
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
                                          poll
                                              ? SizedBox()
                                              : Text(
                                                  "Select Type",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(18),
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                              poll
                                                  ? SizedBox()
                                                  : Column(children: <Widget>[
                                                      IconButton(
                                                          icon: Icon(Icons
                                                              .edit_rounded),
                                                          iconSize: ScreenUtil()
                                                              .setHeight(30),
                                                          color: Colors
                                                              .yellow[700],
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
                                                            fontSize:
                                                                ScreenUtil()
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
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              //   width: ScreenUtil().setWidth(100),
                              child: Text(
                            "Host a Poll",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w600),
                          )),
                          IconButton(
                              icon: poll
                                  ? Icon(Icons.poll_rounded,
                                      color: Colors.lightGreen,
                                      size: ScreenUtil().setHeight(25))
                                  : Icon(Icons.radio_button_off_rounded,
                                      color: Colors.grey,
                                      size: ScreenUtil().setHeight(25)),
                              onPressed: () {
                                setState(() {
                                  if (widget.postType == "text") {
                                    widget.postType = "";
                                  }
                                  if (poll) {
                                    poll = false;
                                  } else {
                                    poll = true;
                                  }
                                });
                              }),
                        ],
                      ),
                      SizedBox(
                        height: poll ? ScreenUtil().setHeight(15) : 0,
                      ),
                      poll
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(140),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(10)),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setHeight(20)))),
                                    child: Text(
                                      endDate == null
                                          ? "Select End Date"
                                          : DateFormat('d MMMM, y')
                                              .format(endDate)
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ),
                                  onTap: () async {
                                    DateTime pickDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate:
                                            DateTime(DateTime.now().year),
                                        lastDate:
                                            DateTime(DateTime.now().year + 1));
                                    if (pickDate != null) {
                                      if (mounted) {
                                        setState(() {
                                          endDate = pickDate;
                                        });
                                      }
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(20),
                                ),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: ScreenUtil().setWidth(140),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(10)),
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenUtil().setHeight(20)))),
                                    child: Text(
                                      endTime == null
                                          ? "Select End Time"
                                          : "${endTime.hourOfPeriod}:${endTime.minute} ${endTime.period.toString().substring(10)}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(14)),
                                    ),
                                  ),
                                  onTap: () async {
                                    TimeOfDay pickTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now());
                                    if (pickTime != null) {
                                      if (mounted) {
                                        setState(() {
                                          endTime = pickTime;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
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
                                    hintText:
                                        poll ? "Poll Question?" : "Caption...",
                                    hintStyle: TextStyle(color: Colors.grey)),
                                controller: caption,
                                style: TextStyle(color: Colors.black),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autocorrect: true,
                                enableSuggestions: true,
                              )),
                      poll
                          ? ListView.builder(
                              itemCount: optCount,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(40)),
                                    width: ScreenUtil().setWidth(360),
                                    child: Stack(
                                      alignment: Alignment.centerRight,
                                      children: <Widget>[
                                        TextFormField(
                                          controller: contList[index],
                                          decoration: InputDecoration(
                                              prefixIcon: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                              .setHeight(5) +
                                                          ScreenUtil().setSp(8),
                                                      left: ScreenUtil()
                                                          .setWidth(20)),
                                                  child: Text("${index + 1}.")),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: index == 0
                                                      ? BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                            ScreenUtil()
                                                                .setHeight(10),
                                                          ),
                                                          topRight:
                                                              Radius.circular(
                                                                  ScreenUtil()
                                                                      .setHeight(
                                                                          10)))
                                                      : BorderRadius.zero,
                                                  borderSide: BorderSide(
                                                      color: acolor.primary,
                                                      width: 0.5)),
                                              focusColor: acolor.primary,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: index == 0
                                                      ? BorderRadius.only(
                                                          topLeft: Radius.circular(
                                                            ScreenUtil()
                                                                .setHeight(10),
                                                          ),
                                                          topRight: Radius.circular(ScreenUtil().setHeight(10)))
                                                      : BorderRadius.zero,
                                                  borderSide: BorderSide(color: acolor.primary, width: 0.5)),
                                              contentPadding: EdgeInsets.only(top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(5), left: ScreenUtil().setWidth(20)),
                                              hintText: "Option ${index + 1}",
                                              hintStyle: TextStyle(color: Colors.grey)),
                                        ),
                                        index != 0
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {
                                                  if (mounted) {
                                                    setState(() {
                                                      optCount--;
                                                      int j =
                                                          contList.length - 1;
                                                      var t;
                                                      contList[index].text = "";
                                                      for (int i = index;
                                                          i < j;
                                                          i++) {
                                                        t = contList[i];
                                                        contList[i] =
                                                            contList[i + 1];
                                                        contList[i + 1] = t;
                                                      }
                                                      contList.removeLast();
                                                    });
                                                  }
                                                },
                                              )
                                            : SizedBox(),
                                      ],
                                    ));
                              })
                          : SizedBox(),
                      poll
                          ? GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(40)),
                                width: ScreenUtil().setWidth(360),
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(10),
                                    bottom: ScreenUtil().setHeight(10),
                                    left: ScreenUtil().setWidth(10)),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: acolor.primary, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                          ScreenUtil().setHeight(10),
                                        ),
                                        bottomRight: Radius.circular(
                                            ScreenUtil().setHeight(10)))),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.menu,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(5),
                                    ),
                                    Text(
                                      "Add an option...",
                                      style: TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    contList.add(new TextEditingController());
                                    optCount++;
                                  });
                                }
                              },
                            )
                          : SizedBox(),
                      SizedBox(height: ScreenUtil().setHeight(10)),
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
                              bottom: ScreenUtil().setHeight(20)),
                          child: CircleAvatar(
                            radius: ScreenUtil().setHeight(22),
                            backgroundColor: acolor.primary,
                            child: IconButton(
                              icon: Icon(Icons.check_rounded),
                              color: Colors.white,
                              onPressed: () {
                                if (poll == false) {
                                  if (widget.postType == "") {
                                    return snackBar(
                                        "Content Empty , Can't Post!");
                                  } else if (widget.postType == "text") {
                                    if (_controller.text == null) {
                                      return snackBar(
                                          "Content Empty , Can't Post!");
                                    } else {
                                      if (_controller.text.trim() == "") {
                                        return snackBar(
                                            "Content Empty , Can't Post!");
                                      } else {
                                        createPost();
                                        Navigator.of(context).pop();
                                        return;
                                      }
                                    }
                                  } else {
                                    createPost();
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                } else if (poll) {
                                  if (caption.text == null) {
                                    return snackBar(
                                        "Poll Question is Required");
                                  } else if (caption.text.trim() == "") {
                                    return snackBar(
                                        "Poll Question is Required");
                                  } else if (contList[0].text == null ||
                                      contList[0].text == "") {
                                    return snackBar("Options Are Required");
                                  } else if (endDate == null ||
                                      endTime == null) {
                                    return snackBar(
                                        "End Date and Time are Required");
                                  } else {
                                    createPost();
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                }
                              },
                            ),
                          ))
                    ],
                  ));
            }));
  }
}
