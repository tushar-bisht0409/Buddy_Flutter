import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:dio/dio.dart';

class FeedBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _feedInfoSink => _stateStreamController.sink;
  Stream<dynamic> get feedInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<FeedInfo>();
  StreamSink<FeedInfo> get eventSink => _eventStreamController.sink;
  Stream<FeedInfo> get _eventStream => _eventStreamController.stream;

  FeedBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == 'receive') {
          response = await dio.get(serverURl + '/getfeed', queryParameters: {
            "feedID": event.feedID,
            "type": event.getType,
            "academia": event.academia,
            "creators": event.following
          });
        } else if (event.action == 'send') {
          FormData data;
          if (event.mediaCategory == 'text') {
            data = FormData.fromMap({
              "feedID": event.feedID,
              "caption": event.caption,
              "creatorName": event.creatorName,
              "creatorID": event.creatorID,
              "createdAt": event.createdAt,
              "category": event.category,
              "mediaCategory": event.mediaCategory,
              "academia": event.academia,
              "timestamp": event.timestamp,
            });
          } else {
            String fileName = event.mediaPath.split("/").last;
            data = FormData.fromMap({
              "feedID": event.feedID,
              "caption": event.caption,
              "creatorName": event.creatorName,
              "creatorID": event.creatorID,
              "createdAt": event.createdAt,
              "category": event.category,
              "mediaCategory": event.mediaCategory,
              "academia": event.academia,
              "timestamp": event.timestamp,
              "file": await MultipartFile.fromFile(event.mediaPath,
                  filename: fileName)
            });
          }
          response = await dio.post(serverURl + '/postfeed', data: data);
        }
      } catch (e) {
        print(e);
      }
      _feedInfoSink.add([response.data['msz'], response.data['success']]);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
