import 'dart:io';

import 'package:buddy/blocs/feed_bloc.dart';
import 'package:buddy/blocs/filebase64_bloc.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:buddy/widgets/feedgridcontent.dart';
import 'package:buddy/widgets/loadmedia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedGrid extends StatelessWidget {
  FeedBloc feedbloc = FeedBloc();
  FeedInfo feed = FeedInfo();
  FileBase64Bloc base64bloc = FileBase64Bloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: feedbloc.feedInfoStream,
        builder: (ctx, snapshot) {
          feed.action = "receive";
          feed.getType = "Following"; //Following // World // Academia
          feed.following = ["12345678"]; // Only UserID
          feed.academia = "";
          feedbloc.eventSink.add(feed);
          var feedInfo;
          if (snapshot.hasData) {
            if (snapshot.data[1] == false) {
              return Text("No Post");
            }
            feedInfo = snapshot.data[0];

            return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.2, crossAxisCount: 2),
                itemCount: feedInfo.length,
                itemBuilder: (BuildContext context, int index) {
                  return FeedGridContent(feedInfo, index);
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
