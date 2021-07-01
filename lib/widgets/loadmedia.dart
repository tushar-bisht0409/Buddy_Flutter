import 'dart:io';

import 'package:buddy/blocs/filebase64_bloc.dart';
import 'package:flutter/material.dart';

class LoadMedia extends StatelessWidget {
  var mediaPath;
  LoadMedia(this.mediaPath);

  FileBase64Bloc mediabloc = FileBase64Bloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mediabloc.base64Stream,
        builder: (ctx, snapshot) {
          mediabloc.eventSink.add([mediaPath, "Post"]);
          if (snapshot.hasData) {
            return Image.file(
              File(snapshot.data),
              fit: BoxFit.fitWidth,
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
