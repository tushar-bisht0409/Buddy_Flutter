import 'dart:async';

import 'package:buddy/main.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:buddy/models/saveInfo.dart';
import 'package:buddy/screens/authscreen.dart';
import 'package:dio/dio.dart';

class SaveInfoBloc {
  SaveInfo info = SaveInfo();
  String success;

  final _stateStreamController = StreamController<bool>.broadcast();
  StreamSink<bool> get _saveinfoSink => _stateStreamController.sink;
  Stream<bool> get saveinfoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<SaveInfo>();
  StreamSink<SaveInfo> get eventSink => _eventStreamController.sink;
  Stream<SaveInfo> get _eventStream => _eventStreamController.stream;

  SaveInfoBloc() {
    _eventStream.listen((event) async {
      var response;
      var responseID;

      try {
        dio.options.headers['Authorization'] = 'Bearer $token';
        responseID = await dio.get(
          serverURl + "/getid",
        );
        userID = responseID.data['userID'];
        print(responseID.data);
        print(userID);
      } catch (e) {
        print('error');
      }
      if (responseID.data['success'] == true) {
        userID = responseID.data['userID'];
        try {
          response = await dio.post(serverURl + "/saveinfo",
              data: {
                "userID": userID,
                "name": event.name,
                "institution": event.institution,
                "course": event.course,
                "subject": event.subject,
                "startYear": event.startYear
              },
              options: Options(contentType: Headers.formUrlEncodedContentType));
        } on HttpException catch (e) {
          print(e);
        }
        if (response.data['success']) {
          authMode = AuthMode.Login;
        }
        _saveinfoSink.add(response.data['success']);
      } else {
        _saveinfoSink.add(false);
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
