import 'dart:io';

import 'package:buddy/blocs/chat_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  static const routeName = '/video_view';
  const VideoViewScreen({Key key, this.path}) : super(key: key);
  final String path;

  @override
  _VideoViewScreenState createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  VideoPlayerController _controller;
  var chatbloc = ChatBloc();
  var mszobj = MessageInfo();
  final _controllerText = new TextEditingController();

  void _sendMessage() {
    mszobj.action = 'send';
    mszobj.chatID = '12';
    mszobj.senderName = "";
    mszobj.receiverID = '';
    mszobj.senderID = "1";
    mszobj.text = _controllerText.text;
    mszobj.status = 'unread';
    mszobj.category = "video";
    mszobj.mediaPath = widget.path;
    mszobj.createdAt = DateFormat(
      'h:m a',
    ).format(DateTime.now()).toString();
    mszobj.timestamp = DateTime.now().toString();
    chatbloc.eventSink.add(mszobj);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          // IconButton(
          //     icon: Icon(
          //       Icons.crop_rotate,
          //       size: 27,
          //     ),
          //     onPressed: () {}),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 150,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: TextFormField(
                  controller: _controllerText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add Caption....",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      suffixIcon: CircleAvatar(
                        radius: 27,
                        backgroundColor: acolor.primary,
                        child: IconButton(
                          icon: Icon(Icons.send_rounded),
                          color: Colors.white,
                          onPressed: () {
                            _sendMessage();
                            Navigator.of(context).pop();
                          },
                        ),
                      )),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
