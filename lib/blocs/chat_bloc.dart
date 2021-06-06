import 'dart:async';
import 'package:buddy/main.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:buddy/models/messageinfo.dart';
import 'package:dio/dio.dart';

class ChatBloc {
  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _messageInfoSink => _stateStreamController.sink;
  Stream<dynamic> get messageInfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MessageInfo>();
  StreamSink<MessageInfo> get eventSink => _eventStreamController.sink;
  Stream<MessageInfo> get _eventStream => _eventStreamController.stream;

  ChatBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == 'receive') {
          response = await dio.get(serverURl + '/gettextmsz',
              queryParameters: {"chatID": "12"});
        } else if (event.action == 'send') {
          response = await dio.post(serverURl + '/posttextmsz',
              data: {
                "chatID": event.chatID,
                "text": event.text,
                "senderID": event.senderID,
                "receiverID": event.receiverID,
                "status": event.status,
                "createdAt": event.createdAt,
                "timestamp": event.timestamp
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
        }
      } catch (e) {
        print(e);
      }
      _messageInfoSink.add(response.data['msz']);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
