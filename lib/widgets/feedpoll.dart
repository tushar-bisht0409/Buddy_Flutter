import 'package:buddy/blocs/feed_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/feedinfo.dart';
import 'package:buddy/widgets/loadmedia.dart';
import 'package:buddy/widgets/pollchart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedPoll extends StatefulWidget {
  var feedID;
  var mediaCategory;
  var caption;
  var mediaPath;
  var options;
  var voters;
  var endDate;
  var endTime;
  var endtimestamp;

  FeedPoll(this.feedID, this.mediaCategory, this.caption, this.mediaPath,
      this.options, this.voters, this.endDate, this.endTime, this.endtimestamp);

  @override
  _FeedPollState createState() => _FeedPollState();
}

class _FeedPollState extends State<FeedPoll> {
  var opt;
  final votebloc = FeedBloc();
  var voteinfo = FeedInfo();
  var results = {};
  var decider;
  void sendVote(var vote, var option) {
    voteinfo.action = "vote";
    voteinfo.caption = option;
    voteinfo.category = vote;
    voteinfo.feedID = widget.feedID;
    votebloc.eventSink.add(voteinfo);
  }

  void generateResults() {
    for (int j = 0; j < widget.options.length; j++) {
      int count = 0;
      for (int i = 0; i < widget.voters.length; i++) {
        if (widget.voters[i]["option"] == widget.options[j]) {
          count++;
        }
        results["${widget.options[j]}"] = (count / widget.voters.length) * 100;
      }
    }
    print(results["${widget.options[0]}"]);
  }

  void checkOption() {
    if (!widget.voters.isEmpty) {
      for (int i = 0; i < widget.voters.length; i++) {
        if (widget.voters[i]["voterID"] == "1" //userID
            ) {
          opt = widget.voters[i]["option"];
        }
      }
    }
  }

  @override
  void initState() {
    checkOption();
    generateResults();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    decider = DateTime.parse(widget.endtimestamp).compareTo(DateTime.now());
    return StreamBuilder(
        stream: votebloc.feedInfoStream,
        builder: (ctx, snapshot) {
          return Column(
            children: <Widget>[
              widget.mediaCategory == 'text'
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenUtil().setHeight(10),
                          horizontal: ScreenUtil().setWidth(10)),
                      alignment: Alignment.centerLeft,
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.poll_rounded,
                          size: ScreenUtil().setHeight(25),
                          color: acolor.primary,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Text(
                          widget.caption,
                          style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                        ),
                      ]))
                  : Container(
                      alignment: Alignment.center,
                      height: ScreenUtil().setHeight(300),
                      color: Colors.black,
                      child: LoadMedia(widget.mediaPath)),
              decider == -1
                  ? SizedBox()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.options.length,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(30),
                                vertical: ScreenUtil().setHeight(5)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setHeight(15))),
                            ),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ScreenUtil().setWidth(20),
                                    vertical: ScreenUtil().setHeight(10)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setHeight(15))),
                                ),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.circle,
                                    size: ScreenUtil().setWidth(10),
                                    color: opt == widget.options[index]
                                        ? Colors.lightGreen
                                        : opt != null
                                            ? Colors.white
                                            : Colors.grey[300],
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(10),
                                  ),
                                  Text(widget.options[index]),
                                ])),
                          ),
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                if (opt == null) {
                                  opt = widget.options[index];
                                  sendVote("vote", opt);
                                }
                              });
                            }
                          },
                        );
                      }),
              opt != null
                  ? TextButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(5),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              acolor.secondary)),
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            sendVote("unvote", opt);
                            opt = null;
                          });
                        }
                      },
                      child: Text("Unvote"))
                  : SizedBox(
                      height: 0,
                    ),
              Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                child: Text(
                  "Poll Ends At: ${widget.endTime}, ${widget.endDate}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      color: Colors.grey,
                      fontStyle: FontStyle.normal),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              decider == 1
                  ? SizedBox()
                  : Container(
                      height: 150.h,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          itemBuilder: (ctx, index) {
                            return PollChart(
                              results["${widget.options[index]}"],
                              "${widget.options[index]}",
                            );
                          })),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              )
            ],
          );
        });
  }
}
