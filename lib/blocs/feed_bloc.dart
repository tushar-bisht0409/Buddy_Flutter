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
          if (event.poll == false) {
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
                "poll": event.poll,
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
                "poll": event.poll,
                "timestamp": event.timestamp,
                "file": await MultipartFile.fromFile(event.mediaPath,
                    filename: fileName)
              });
            }
          } else {
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
                "poll": event.poll,
                "timestamp": event.timestamp,
                "options": event.options,
                "endDate": event.endDate,
                "endTime": event.endTime,
                "endtimeStamp": event.endtimestamp,
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
                "poll": event.poll,
                "timestamp": event.timestamp,
                "options": event.options,
                "endDate": event.endDate,
                "endTime": event.endTime,
                "endtimeStamp": event.endtimestamp,
                "file": await MultipartFile.fromFile(event.mediaPath,
                    filename: fileName)
              });
            }
          }
          response = await dio.post(serverURl + '/postfeed', data: data);
        } else if (event.action == "vote") {
          var votedata = {
            "userID": "1", //userID,
            "feedID": event.feedID,
            "option": event.caption,
            "vote": event.category
          };

          response = await dio.post(
            serverURl + '/postfeedvote',
            data: votedata,
            options: Options(contentType: Headers.formUrlEncodedContentType),
          );
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
