import 'dart:async';
import 'package:buddy/main.dart';
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
          response = await dio
              .get(serverURl + '/getmsz', queryParameters: {"chatID": "12"});
        } else if (event.action == 'send') {
          FormData data;
          if (event.category == 'text') {
            data = FormData.fromMap({
              "chatID": event.chatID,
              "text": event.text,
              "senderName": event.senderName,
              "senderID": event.senderID,
              "receiverID": event.receiverID,
              "status": event.status,
              "createdAt": event.createdAt,
              "category": event.category,
              "timestamp": event.timestamp,
            });
          } else {
            String fileName = event.mediaPath.split("/").last;
            data = FormData.fromMap({
              "chatID": event.chatID,
              "text": event.text,
              "senderName": event.senderName,
              "senderID": event.senderID,
              "receiverID": event.receiverID,
              "status": event.status,
              "createdAt": event.createdAt,
              "category": event.category,
              "timestamp": event.timestamp,
              "file": await MultipartFile.fromFile(event.mediaPath,
                  filename: fileName)
            });
          }
          response = await dio.post(serverURl + '/postmsz', data: data);
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
