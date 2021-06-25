import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/storyinfo.dart';
import 'package:dio/dio.dart';

class StoryBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _storyInfoSink => _stateStreamController.sink;
  Stream<dynamic> get storyInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<StoryInfo>();
  StreamSink<StoryInfo> get eventSink => _eventStreamController.sink;
  Stream<StoryInfo> get _eventStream => _eventStreamController.stream;

  StoryBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == 'receive') {
          response = await dio.get(serverURl + '/getstory', queryParameters: {
            "storyID": event.storyID,
            "getBy": event.getBy,
            "creators": event.following
          });
        } else if (event.action == 'send') {
          FormData data;
          if (event.category == 'text') {
            data = FormData.fromMap({
              "storyID": event.storyID,
              "caption": event.caption,
              "creatorName": event.creatorName,
              "creatorID": event.creatorID,
              "createdAt": event.createdAt,
              "category": event.category,
              "timestamp": event.timestamp,
            });
          } else {
            String fileName = event.mediaPath.split("/").last;
            data = FormData.fromMap({
              "storyID": event.storyID,
              "caption": event.caption,
              "creatorName": event.creatorName,
              "creatorID": event.creatorID,
              "createdAt": event.createdAt,
              "category": event.category,
              "timestamp": event.timestamp,
              "file": await MultipartFile.fromFile(event.mediaPath,
                  filename: fileName)
            });
          }
          response = await dio.post(serverURl + '/poststory', data: data);
        } else if (event.action == "seen") {
          response = await dio.post(serverURl + '/storyseen',
              queryParameters: {"storyID": event.storyID, "userID": userID});
        }
      } catch (e) {
        print(e);
      }
      _storyInfoSink.add([response.data['msz'], response.data['success']]);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
