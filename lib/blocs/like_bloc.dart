import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';

class LikeBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _likeInfoSink => _stateStreamController.sink;
  Stream<dynamic> get likeInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<FeedInfo>();
  StreamSink<FeedInfo> get eventSink => _eventStreamController.sink;
  Stream<FeedInfo> get _eventStream => _eventStreamController.stream;

  LikeBloc() {
    _eventStream.listen((event) async {
      var response;
      if (event.action == "feed") {
        try {
          response = await dio.post(serverURl + '/postlike', queryParameters: {
            "feedID": event.feedID,
            "senderID": "1", //userID,
            "like": event.like
          });
        } catch (e) {
          print(e);
        }
      } else if (event.action == "comment") {
        try {
          response =
              await dio.post(serverURl + '/postcommentlike', queryParameters: {
            "commentID": event.feedID,
            "senderID": "1", //userID,
            "like": event.like
          });
        } catch (e) {
          print(e);
        }
      } else if (event.action == "commentreply") {
        try {
          response = await dio
              .post(serverURl + '/postcommentreplylike', queryParameters: {
            "commentreplyID": event.feedID,
            "senderID": "1", //userID,
            "like": event.like
          });
        } catch (e) {
          print(e);
        }
      }
      print(response.data);
      _likeInfoSink.add([response.data['msz'], response.data['success']]);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
