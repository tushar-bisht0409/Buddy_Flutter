import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/commentinfo.dart';
import 'package:dio/dio.dart';

class CommentBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _commentInfoSink => _stateStreamController.sink;
  Stream<dynamic> get commentInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CommentInfo>();
  StreamSink<CommentInfo> get eventSink => _eventStreamController.sink;
  Stream<CommentInfo> get _eventStream => _eventStreamController.stream;

  CommentBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == 'receive') {
          if (event.isCommentReply) {
            response = await dio.get(serverURl + '/getcommentreply',
                queryParameters: {"commentID": event.commentID});
          } else {
            response = await dio.get(serverURl + '/getcomment',
                queryParameters: {"feedID": event.feedID});
          }
        } else if (event.action == 'send') {
          if (event.isCommentReply) {
            var commentdata = {
              "commentID": event.commentID,
              "commentreplyID": event.commentreplyID,
              "text": event.text,
              "senderName": event.senderName,
              "senderID": event.senderID,
              "createdAt": event.createdAt,
              "timestamp": event.timestamp,
            };

            response = await dio.post(
              serverURl + '/postcommentreply',
              data: commentdata,
              options: Options(contentType: Headers.formUrlEncodedContentType),
            );
          } else {
            var commentdata = {
              "commentID": event.commentID,
              "feedID": event.feedID,
              "text": event.text,
              "senderName": event.senderName,
              "senderID": event.senderID,
              "createdAt": event.createdAt,
              "timestamp": event.timestamp,
            };

            response = await dio.post(
              serverURl + '/postcomment',
              data: commentdata,
              options: Options(contentType: Headers.formUrlEncodedContentType),
            );
          }
        }
      } catch (e) {
        print(e);
      }
      _commentInfoSink.add([response.data['msz'], response.data['success']]);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
