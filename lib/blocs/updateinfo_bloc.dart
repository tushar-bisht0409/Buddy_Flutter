import 'dart:async';

import 'package:buddy/main.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:buddy/models/userinfo.dart';
import 'package:dio/dio.dart';

class UpdateInfoBloc {
  UserInfo info = UserInfo();
  String success;

  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _updateinfoSink => _stateStreamController.sink;
  Stream<dynamic> get updateinfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<UserInfo>();
  StreamSink<UserInfo> get eventSink => _eventStreamController.sink;
  Stream<UserInfo> get _eventStream => _eventStreamController.stream;

  UpdateInfoBloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        if (event.action == "send") {
          response = await dio.post(serverURl + "/updateinfo",
              data: {
                "userID": "12345678", //userID,
                "type": event.type,
                "skills": event.skill,
                "interest": event.interest,
                "course": event.course,
                "subject": event.subject,
                "company": event.company,
                "role": event.role,
                "worktime": event.worktime,
                "about": event.about,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
        } else if (event.action == "receive") {
          response = await dio.get(serverURl + '/getinfo',
              queryParameters: {"userID": "12345678"});
        }
      } on HttpException catch (e) {
        print(e);
      }
      _updateinfoSink.add(response.data);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
