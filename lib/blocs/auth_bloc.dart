import 'dart:async';

import 'package:buddy/main.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:dio/dio.dart';

enum AuthAction { Signup, Login, Forgot }
var authResult = {'success': false, 'msz': '', 'token': ''};

class AuthBloc {
  String email;
  String password;

  final _stateStreamController = StreamController<dynamic>.broadcast();
  StreamSink<dynamic> get _authSink => _stateStreamController.sink;
  Stream<dynamic> get authStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<List>();
  StreamSink<List> get eventSink => _eventStreamController.sink;
  Stream<List> get _eventStream => _eventStreamController.stream;

  AuthBloc(this.email, this.password) {
    _eventStream.listen((event) async {
      var response;
      var response2;
      email = event[0];
      password = event[1];

      try {
        if (event[2] == AuthAction.Signup) {
          response = await dio.post(serverURl + "/adduser",
              data: {"email": email, "password": password},
              options: Options(contentType: Headers.formUrlEncodedContentType));
          if (response.data['success'] == true) {
            response2 = await dio.post(serverURl + "/authenticate",
                data: {"email": email, "password": password},
                options:
                    Options(contentType: Headers.formUrlEncodedContentType));
            if (response2.data['success'] == true) {
              authResult = {
                'success': response2.data['success'],
                'msz': response2.data['msz'],
                'token': response2.data['token']
              };
              token = response2.data['token'];
            }
          } else {
            authResult = {
              'success': response.data['success'],
              'msz': response.data['msz'],
              'token': ''
            };
            token = '';
          }
        } else if (event[2] == AuthAction.Login) {
          response = await dio.post(serverURl + "/authenticate",
              data: {"email": email, "password": password},
              options: Options(contentType: Headers.formUrlEncodedContentType));
          if (response.data['success'] == true) {
            authResult = {
              'success': response.data['success'],
              'msz': response.data['msz'],
              'token': response.data['token']
            };
            token = response.data['token'];
          } else {
            authResult = {
              'success': response.data['success'],
              'msz': response.data['msz'],
              'token': ''
            };
            token = '';
          }
        } else if (event[2] == AuthAction.Forgot) {
          print("forgot");
        }
      } on HttpException catch (e) {
        print(e);
      }

      _authSink.add(authResult);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
