import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:dio/dio.dart';

class CommentBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _feedInfoSink => _stateStreamController.sink;
  Stream<dynamic> get feedInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<FeedInfo>();
  StreamSink<FeedInfo> get eventSink => _eventStreamController.sink;
  Stream<FeedInfo> get _eventStream => _eventStreamController.stream;

  CommentBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == 'receive') {
          response = await dio.get(serverURl + '/getcomment',
              queryParameters: {"feedID": event.feedID});
        } else if (event.action == 'send') {
          FormData data;
          if (event.category == 'text') {
            data = FormData.fromMap({
              "feedID": event.feedID,
              "text": event.caption,
              "senderName": event.creatorName,
              "senderID": event.creatorID,
              "createdAt": event.createdAt,
              "timestamp": event.timestamp,
            });
          } else {
            String fileName = event.mediaPath.split("/").last;
            data = FormData.fromMap({
              "feedID": event.feedID,
              "text": event.caption,
              "senderName": event.creatorName,
              "senderID": event.creatorID,
              "createdAt": event.createdAt,
              "category": event.category,
              "timestamp": event.timestamp,
              "file": await MultipartFile.fromFile(event.mediaPath,
                  filename: fileName)
            });
          }
          response = await dio.post(serverURl + '/postcomment', data: data);
        }
      } catch (e) {
        print(e);
      }
      _feedInfoSink.add(response.data['msz']);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
