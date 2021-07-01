import 'dart:io';
import 'package:buddy/main.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:buddy/screens/camerscreen.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum MediaCategory { Media, Audio, Any }
var mediacat;
var mszobj = MessageInfo();

void _sendMessage(String mediaPath) async {
  mszobj.action = 'send';
  mszobj.chatID = '12';
  mszobj.senderName = "";
  mszobj.receiverID = '';
  mszobj.senderID = "1";
  mszobj.text = "";
  mszobj.status = 'unread';
  mszobj.category = 'media';
  mszobj.mediaPath = mediaPath;
  mszobj.createdAt = DateFormat(
    'h:m a',
  ).format(DateTime.now()).toString();
  mszobj.timestamp = DateTime.now().toString();
  try {
    FormData data;
    String fileName = mszobj.mediaPath.split("/").last;
    data = FormData.fromMap({
      "chatID": mszobj.chatID,
      "text": mszobj.text,
      "senderName": mszobj.senderName,
      "senderID": mszobj.senderID,
      "receiverID": mszobj.receiverID,
      "status": mszobj.status,
      "createdAt": mszobj.createdAt,
      "category": mszobj.category,
      "timestamp": mszobj.timestamp,
      "file": await MultipartFile.fromFile(mszobj.mediaPath, filename: fileName)
    });

    var response = await dio.post(serverURl + '/postmsz', data: data);
    print(response.data);
  } catch (e) {
    print(e);
  }
}

void selectFile() async {
  FilePickerResult result;
  if (mediacat == MediaCategory.Media) {
    result = await FilePicker.platform.pickFiles(
        allowMultiple: true, allowCompression: true, type: FileType.media);
  } else if (mediacat == MediaCategory.Any) {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.any);
  } else if (mediacat == MediaCategory.Audio) {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.audio);
  }

  if (result == null) {
    print('jj');
    return;
  }
  List<File> files = result.paths.map((path) => File(path)).toList();
  print('yoooo ${files[0].path}');
  for (int i = 0; i < files.length; i++) {
    print('soooo ${files[i].path}');
    _sendMessage(files[i].path);
  }
}

Widget attachments(BuildContext context) {
  void openCamera() {
    Navigator.push(context,
        MaterialPageRoute(builder: (builder) => CameraScreen("Message")));
  }

  Widget iconCreation(
      IconData icons, Color color, String text, Function action, var mcat) {
    return InkWell(
      onTap: () {
        mediacat = mcat;
        action();
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: ScreenUtil().setWidth(22),
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: ScreenUtil().setWidth(20),
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(12),
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }

  return Container(
    margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(5),
        left: ScreenUtil().setWidth(5),
        right: ScreenUtil().setWidth(5)),
    height: ScreenUtil().setHeight(110),
    width: ScreenUtil().setWidth(360),
    child: Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(15))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconCreation(Icons.camera_alt_rounded, Colors.pink[400], "Camera",
                openCamera, MediaCategory.Any),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            iconCreation(Icons.insert_photo_rounded, Colors.lightGreen,
                "Gallery", selectFile, MediaCategory.Media),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            iconCreation(Icons.insert_drive_file_rounded, Colors.lightBlue,
                "Document", selectFile, MediaCategory.Any),
            SizedBox(
              width: ScreenUtil().setWidth(30),
            ),
            iconCreation(Icons.headset_rounded, Colors.orange, "Audio",
                selectFile, MediaCategory.Audio),
          ],
        ),
      ),
    ),
  );
}
