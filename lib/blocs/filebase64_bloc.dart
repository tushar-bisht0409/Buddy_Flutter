import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:buddy/main.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:buddy/models/saveInfo.dart';
import 'package:buddy/screens/homescreen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class FileBase64Bloc {
  SaveInfo info = SaveInfo();
  String success;

  final _stateStreamController = StreamController<String>.broadcast();
  StreamSink<String> get _base64Sink => _stateStreamController.sink;
  Stream<String> get base64Stream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>();
  StreamSink<String> get eventSink => _eventStreamController.sink;
  Stream<String> get _eventStream => _eventStreamController.stream;

  FileBase64Bloc() {
    _eventStream.listen((event) async {
      var response;

      try {
        var mediaDir = "Images";
        var finalDir = join(appDir.path, mediaDir);
        var fileDir = Directory(finalDir);
        bool dirsxist = await fileDir.exists();
        if (dirsxist == false) {
          await fileDir.create(recursive: true);
        }
        // var fileDir =
        //     await Directory('${appDir.path}/images').create(recursive: true);

        if (File("${fileDir.path}/$event").existsSync() == false) {
          File("${fileDir.path}/$event")
              .create(recursive: true)
              .then((file) async {
            print('new');
            response = await dio.get(serverURl + "/getfile",
                queryParameters: {"filename": event});
            if (response.data['success']) {
              Uint8List bytes = base64.decode(response.data['msz']);
              await file
                  .writeAsBytes(bytes)
                  .then((value) => _base64Sink.add("${fileDir.path}/$event"));
            }
          });
        } else if (File("${fileDir.path}/$event").lengthSync() == 0) {
          File("${fileDir.path}/$event")
              .create(recursive: true)
              .then((file) async {
            print('new');
            response = await dio.get(serverURl + "/getfile",
                queryParameters: {"filename": event});
            if (response.data['success']) {
              Uint8List bytes = base64.decode(response.data['msz']);
              await file
                  .writeAsBytes(bytes)
                  .then((value) => _base64Sink.add("${fileDir.path}/$event"));
            }
          });
        } else {
          _base64Sink.add("${fileDir.path}/$event");
        }
      } on HttpException catch (e) {
        print(e);
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
