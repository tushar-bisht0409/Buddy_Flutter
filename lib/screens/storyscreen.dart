import 'dart:async';
import 'dart:io';

import 'package:buddy/blocs/filebase64_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
// import 'package:path/path.dart';
// import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  static const routeName = '/story';
  StoryScreen(this.storyInfo, this.storyBy, this.currentIndex);
  var storyInfo;
  var storyBy;
  var currentIndex;

  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  var mediabloc = FileBase64Bloc();
  var mszobj = MessageInfo();
  final _controller = new TextEditingController();
  var stories = {};
  var singleStory = [];
  var storyIndex; // storyBy index
  var inIndex; // story index of stories of a single creator
  // VideoPlayerController _videoController;
  var storyTimer;
  String filePath;
  bool exitStory = false;

  void _sendMessage() {
    mszobj.action = 'send';
    mszobj.chatID = '12';
    mszobj.senderName = "";
    mszobj.receiverID = '';
    mszobj.senderID = "1";
    mszobj.text = _controller.text;
    mszobj.status = 'unread';
    mszobj.category = "image";
    // mszobj.mediaPath = path;
    mszobj.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    mszobj.timestamp = DateTime.now().toString();
    //  chatbloc.eventSink.add(mszobj);
  }

  bool storyLoading = true;
  var currentStory = [];
  var storyCategory;
  var mediaPath;
  var caption;
  String creatorID;

  @override
  void initState() {
    storyIndex = widget.currentIndex;
    inIndex = 0;
    for (int i = 0; i < widget.storyBy.length; i++) {
      print(widget.storyBy[i]);
      stories["${widget.storyBy[i]}"] = [];
    }
    for (int i = 0; i < widget.storyInfo.length; i++) {
      var arr = stories["${widget.storyInfo[i]["creatorID"]}"];
      if (arr.isEmpty) {
        stories.update("${widget.storyInfo[i]["creatorID"]}",
            (value) => [widget.storyInfo[i]]);
      } else {
        arr.add(widget.storyInfo[i]);
        stories.update("${widget.storyInfo[i]["creatorID"]}", (value) => arr);
      }
    }
    // _videoController = VideoPlayerController.file(File(
    //     "/storage/emulated/0/Android/data/com.inso.buddy/files/Buddy/Story/abc.mp4"))
    //   ..initialize().then((_) {
    //     setState(() {});
    //     print("ggg ${_videoController.value}");
    //   });
    super.initState();
  }

  void dispose() {
    if (storyTimer != null) {
      storyTimer.cancel();
    }
    mediabloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    creatorID = widget.storyBy[storyIndex];
    currentStory = stories["$creatorID"];
    storyCategory = stories["$creatorID"][inIndex]["category"];
    mediaPath = stories["$creatorID"][inIndex]["mediaPath"];
    caption = stories["$creatorID"][inIndex]["caption"];
    void changeStory(int secTime) {
      storyLoading = false;
      storyTimer = Timer(Duration(seconds: secTime), () {
        if (mounted) {
          setState(() {
            filePath = null;

            if (inIndex == currentStory.length - 1) {
              if (storyIndex == widget.storyBy.length - 1) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                });
                exitStory = true;
              } else {
                storyIndex++;
                inIndex = 0;
                storyLoading = true;
              }
            } else {
              inIndex++;
              storyLoading = true;
            }
          });
        }
      });
    }

    if (storyCategory == "text" && storyLoading == true) {
      if (mounted) {
        setState(() {
          if (storyTimer != null) {
            storyTimer.cancel();
          }
          changeStory(5);
          print('yoo');
        });
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: mediabloc.base64Stream,
          builder: (ctx, snapshot) {
            if (exitStory) {
              print('exit');
            }
            print("$storyCategory  $filePath");
            if (storyCategory != "text") {
              mediabloc.eventSink.add([mediaPath, "Story"]);

              if (snapshot.hasData && storyCategory == "image") {
                if (storyLoading) {
                  changeStory(5);
                }
                filePath = snapshot.data;
              }
            }
            // if (snapshot.hasData && storyCategory == "video") {
            //   print('ggg $filePath');
            //   _videoController = VideoPlayerController.file(File(filePath))
            //     ..initialize().then((_) {
            //       print("ggg ${_videoController.value}");
            //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            //       if (mounted) {
            //         setState(() {
            //   var timeSec = _videoController.value.duration.inSeconds;
            //   storyTimer = Timer(Duration(seconds: timeSec), () {
            //     if (inIndex == currentStory.length - 1) {
            //       if (storyIndex == widget.storyBy.length - 1) {
            //         WidgetsBinding.instance.addPostFrameCallback((_) {
            //           Navigator.of(context).pop();
            //         });
            //       } else {
            //         storyIndex++;
            //         inIndex = 0;
            //       }
            //     } else {
            //       inIndex++;
            //     }
            //   });
            //         });
            //       }
            //     });
            //   print(_videoController.value.duration.inSeconds);
            // }

            return ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(5),
                      vertical: ScreenUtil().setHeight(10)),
                  height: ScreenUtil().setHeight(21.5),
                  width: ScreenUtil().setWidth(360),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(ScreenUtil().setWidth(5)))),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: currentStory.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                            margin: EdgeInsets.only(
                                right: ScreenUtil().setWidth(5)),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(5))),
                              color: Colors.white,
                            ),
                            height: ScreenUtil().setHeight(1.5),
                            width: (ScreenUtil().setWidth(350) -
                                    ScreenUtil().setWidth(5) *
                                        currentStory.length) /
                                currentStory.length);
                      }),
                ),
                Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        decoration: BoxDecoration(
                            color: acolor.primary,
                            border: Border.all(
                              color: Colors.white,
                              width: ScreenUtil().setHeight(2),
                            ),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setHeight(22))),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: ScreenUtil().setHeight(20),
                        )),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    Text(
                      currentStory[inIndex]["creatorName"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(14)),
                    )
                  ],
                ),
                Stack(children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(360),
                    height: ScreenUtil().setHeight(690) -
                        ScreenUtil().setHeight(44) -
                        ScreenUtil().setHeight(41.5),
                    child: storyCategory == "text"
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(20),
                                vertical: ScreenUtil().setHeight(20)),
                            alignment: Alignment.center,
                            color: Colors.black,
                            constraints: BoxConstraints(
                                maxHeight: ScreenUtil().setHeight(690) -
                                    ScreenUtil().setHeight(44) -
                                    ScreenUtil().setHeight(41.5) -
                                    ScreenUtil().setHeight(20)),
                            child: Text(
                              caption,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20)),
                            ),
                          )
                        : snapshot.hasData == false || filePath == null
                            ? Center(child: CircularProgressIndicator())
                            : filePath.split(".").last != "mp4"
                                ? Image.file(
                                    File(filePath),
                                    fit: BoxFit.fitWidth,
                                  )
                                // : _videoController.value.isInitialized
                                //     ? AspectRatio(
                                //         aspectRatio:
                                //             _videoController.value.aspectRatio,
                                //         child: VideoPlayer(_videoController),
                                //       )
                                : Container(),
                  ),
                  GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      width: ScreenUtil().setWidth(360),
                      height: ScreenUtil().setHeight(690) -
                          ScreenUtil().setHeight(44) -
                          ScreenUtil().setHeight(41.5),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                              width: ScreenUtil().setWidth(180),
                            ),
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  filePath = null;
                                  if (storyTimer != null) {
                                    storyTimer.cancel();
                                  }
                                  if (inIndex == 0) {
                                    if (storyIndex != 0) {
                                      inIndex = 0;
                                      storyIndex--;
                                    }
                                  } else {
                                    inIndex--;
                                  }
                                });
                              }
                              print('left');
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              color: Colors.transparent,
                              width: ScreenUtil().setWidth(180),
                            ),
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  filePath = null;
                                  if (storyTimer != null) {
                                    storyTimer.cancel();
                                  }
                                  if (inIndex == currentStory.length - 1) {
                                    if (storyIndex ==
                                        widget.storyBy.length - 1) {
                                      Navigator.of(context).pop();
                                    } else {
                                      storyIndex++;
                                      inIndex = 0;
                                    }
                                  } else {
                                    inIndex++;
                                  }
                                });
                              }
                              print('right');
                            },
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () {
                      print('pause');
                    },
                  )
                ])
              ],
            );
          }),
    );
  }
}
