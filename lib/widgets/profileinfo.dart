import 'dart:math';

import 'package:buddy/blocs/updateinfo_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/userinfo.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfo extends StatefulWidget {
  var isMe;
  ProfileInfo(this.isMe);
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  List<Color> colorList = [
    Colors.cyanAccent,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.tealAccent,
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.indigoAccent,
  ];
  Color selectColor() {
    var rng = Random();
    return colorList[rng.nextInt(8)];
  }

  UpdateInfoBloc updatebloc = UpdateInfoBloc();
  UpdateInfoBloc infobloc = UpdateInfoBloc();
  UserInfo uinfo = UserInfo();
  UserInfo updateinfo = UserInfo();
  final editController = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController institute = TextEditingController();
  var infos;

  void _showEdit1Dialog(String type, String old) async {
    editController.text = old;
    var newInfo = UserInfo();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.h))),
        title: Text(type.toUpperCase()),
        content: Container(
            width: ScreenUtil().setWidth(200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.h),
              color: acolor.ternary,
              shape: BoxShape.rectangle,
            ),
            child: TextField(
              cursorColor: Colors.black,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onSubmitted: (value) {},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(5),
                      bottom: ScreenUtil().setHeight(5),
                      left: ScreenUtil().setWidth(10)),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38)),
              controller: editController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              autofocus: true,
              onChanged: (value) {},
            )),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              newInfo.type = type;
              newInfo.action = "send";
              newInfo.institution = editController.text;
              newInfo.interest = editController.text;
              newInfo.skill = editController.text;
              newInfo.about = editController.text;
              if (editController.text.trim() != "") {
                updatebloc.eventSink.add(newInfo);
                uinfo.action = "receive";
                infobloc.eventSink.add(uinfo);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fill all the fields.")));
              }
            },
          )
        ],
      ),
    );
  }

  void _showEdit2Dialog(String oldCourse, String oldSubject) async {
    var newInfo = UserInfo();
    course.text = oldCourse;
    subject.text = oldSubject;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.h))),
        title: Text("Course & Subject"),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Course/Degree',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(280),
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        child: DropDownField(
                          controller: course,
                          strict: false,
                          //    value: user.category,
                          icon: null,
                          required: true,
                          hintText: 'Your Course',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          enabled: true,
                          items: [],
                          //  itemsVisibleInDropdown: 5,
                          onValueChanged: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          setter: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ))
                  ])),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Branch/Trade/Subject',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(280),
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        child: DropDownField(
                          controller: subject,
                          strict: false,
                          //    value: user.category,
                          icon: null,
                          required: true,
                          hintText: 'Your Subject',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          enabled: true,
                          items: [],
                          //  itemsVisibleInDropdown: 5,
                          onValueChanged: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          setter: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ))
                  ])),
        ])),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              newInfo.type = "course";
              newInfo.action = "send";
              newInfo.course = course.text;
              newInfo.subject = subject.text;
              if (course.text.trim() != "" && subject.text.trim() != "") {
                updatebloc.eventSink.add(newInfo);
                uinfo.action = "receive";
                infobloc.eventSink.add(uinfo);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fill all the fields.")));
              }
            },
          )
        ],
      ),
    );
  }

  void _showEdit3Dialog() async {
    var newInfo = UserInfo();
    final comp = TextEditingController();
    final rol = TextEditingController();
    final wtime = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.h))),
        title: Text("Experience"),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Company',
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: acolor.ternary,
                          shape: BoxShape.rectangle,
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              hintText: "Company Name",
                              contentPadding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5),
                                  bottom: ScreenUtil().setHeight(5),
                                  left: ScreenUtil().setWidth(10)),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black38)),
                          controller: comp,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          autofocus: true,
                          onChanged: (value) {},
                        )),
                  ])),
          Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Role',
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: acolor.ternary,
                          shape: BoxShape.rectangle,
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              hintText: "Your Role",
                              contentPadding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5),
                                  bottom: ScreenUtil().setHeight(5),
                                  left: ScreenUtil().setWidth(10)),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black38)),
                          controller: rol,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          autofocus: true,
                          onChanged: (value) {},
                        )),
                  ])),
          Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Working Duration',
                      style: TextStyle(color: Colors.black),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          color: acolor.ternary,
                          shape: BoxShape.rectangle,
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          maxLines: null,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.newline,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                              hintText: "No. Of Months",
                              contentPadding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5),
                                  bottom: ScreenUtil().setHeight(5),
                                  left: ScreenUtil().setWidth(10)),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.black38)),
                          controller: wtime,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          autofocus: true,
                          onChanged: (value) {},
                        )),
                  ])),
        ])),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              newInfo.type = "experience";
              newInfo.action = "send";
              newInfo.company = comp.text;
              newInfo.role = rol.text;
              newInfo.worktime = wtime.text;
              if (comp.text.trim() != "" &&
                  rol.text.trim() != "" &&
                  wtime.text.trim() != "") {
                updatebloc.eventSink.add(newInfo);
                uinfo.action = "receive";
                infobloc.eventSink.add(uinfo);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fill all the fields.")));
              }
            },
          )
        ],
      ),
    );
  }

  void _showEdit4Dialog(String oldInstitute) async {
    var newInfo = UserInfo();
    institute.text = oldInstitute;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.h))),
        title: Text("Course & Subject"),
        content: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(30),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Institution',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Container(
                        width: ScreenUtil().setWidth(280),
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        child: DropDownField(
                          controller: institute,
                          strict: false,
                          //    value: user.category,
                          icon: null,
                          required: true,
                          hintText: 'Your Institution',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          enabled: true,
                          items: [],
                          //  itemsVisibleInDropdown: 5,
                          onValueChanged: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                          setter: (newValue) {
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        ))
                  ])),
        ])),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Save'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(acolor.primary),
            ),
            onPressed: () {
              newInfo.type = "course";
              newInfo.action = "send";
              newInfo.course = course.text;
              newInfo.subject = subject.text;
              if (course.text.trim() != "" && subject.text.trim() != "") {
                updatebloc.eventSink.add(newInfo);
                uinfo.action = "receive";
                infobloc.eventSink.add(uinfo);
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Fill all the fields.")));
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    uinfo.action = "receive";
    infobloc.eventSink.add(uinfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infobloc.updateinfoStream,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            infos = snapshot.data["msz"][0];
            var skillArr = infos["skills"];
            var interestArr = infos["interest"];
            var expArr = infos["experience"];
            var sociArr = infos["societies"];
            print(infos);
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 0.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "About",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.edit_rounded,
                                  size: 15.h,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit1Dialog("about", infos["about"]);
                                })
                            : SizedBox()
                      ]),
                ),
                Container(
                  width: 360.w,
                  padding:
                      EdgeInsets.only(left: 20.w, bottom: 10.h, right: 25.w),
                  child: Text(
                    infos["about"] == null || infos["about"] == "null"
                        ? ""
                        : infos["about"],
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 0.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Institution",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.edit_rounded,
                                  size: 15.h,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit4Dialog(infos["institution"]);
                                })
                            : SizedBox()
                      ]),
                ),
                Container(
                  width: 360.w,
                  padding:
                      EdgeInsets.only(left: 20.w, bottom: 10.h, right: 25.w),
                  child: Text(
                    infos["institution"] == null ||
                            infos["institution"] == "null"
                        ? ""
                        : infos["institution"],
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 0.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Branch/Trade",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.edit_rounded,
                                  size: 15.h,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit2Dialog(
                                      infos["course"], infos["subject"]);
                                })
                            : SizedBox()
                      ]),
                ),
                Container(
                  width: 360.w,
                  padding:
                      EdgeInsets.only(left: 20.w, bottom: 10.h, right: 25.w),
                  child: infos["course"] == null ||
                          infos["subject"] == null ||
                          infos["course"] == "null" ||
                          infos["subject"] == "null"
                      ? SizedBox()
                      : Text(
                          "${infos["course"]}(${infos["subject"]})",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.w300),
                        ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 5.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Skills",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit1Dialog("skills", "");
                                })
                            : SizedBox()
                      ]),
                ),
                skillArr.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 60.h,
                        padding: EdgeInsets.only(
                            left: 0.w, top: 5.h, bottom: 5.h, right: 0.w),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: skillArr.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                padding: EdgeInsets.only(
                                    left: 15.w,
                                    top: 10.h,
                                    bottom: 10.h,
                                    right: 15.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.h),
                                    ),
                                    border: Border.all(
                                        color: selectColor(), width: 1.h)),
                                child: Text(
                                  "${skillArr[index]}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            })),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 5.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Interest",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit1Dialog("interest", "");
                                })
                            : SizedBox()
                      ]),
                ),
                interestArr.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 60.h,
                        padding: EdgeInsets.only(
                            left: 0.w, top: 5.h, bottom: 5.h, right: 0.w),
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: interestArr.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                padding: EdgeInsets.only(
                                    left: 15.w,
                                    top: 10.h,
                                    bottom: 10.h,
                                    right: 15.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.h),
                                    ),
                                    border: Border.all(
                                        color: selectColor(), width: 1.h)),
                                child: Text(
                                  "${interestArr[index]}",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              );
                            })),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 5.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Experience",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  _showEdit3Dialog();
                                })
                            : SizedBox()
                      ]),
                ),
                expArr.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 100.h,
                        padding: EdgeInsets.only(
                            left: 0.w, top: 5.h, bottom: 5.h, right: 0.w),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: expArr.length,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  margin:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      top: 10.h,
                                      bottom: 10.h,
                                      right: 15.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.h),
                                      ),
                                      border: Border.all(
                                          color: selectColor(), width: 1.h)),
                                  child: RichText(
                                    text: TextSpan(
                                        text: "${expArr[index]["company"]}\n\n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(14),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "Role: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400,
                                              )),
                                          TextSpan(
                                              text:
                                                  "${expArr[index]["role"]}\n",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w300,
                                              )),
                                          TextSpan(
                                              text: "Worked For: ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400,
                                              )),
                                          TextSpan(
                                              text:
                                                  "${expArr[index]["worktime"]} Months",
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w300,
                                              ))
                                        ]),
                                  ));
                            })),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.only(
                      left: 20.w, top: 10.h, bottom: 5.h, right: 25.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Society & Club",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isMe
                            ? IconButton(
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.green,
                                ),
                                onPressed: () {
                                  print("Exp");
                                })
                            : SizedBox()
                      ]),
                ),
                sociArr.isEmpty
                    ? SizedBox()
                    : Container(
                        height: 150.h,
                        padding: EdgeInsets.only(
                            left: 0.w, top: 5.h, bottom: 5.h, right: 0.w),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sociArr.length,
                            scrollDirection: Axis.horizontal,
                            // physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  margin:
                                      EdgeInsets.only(left: 5.w, right: 5.w),
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      top: 10.h,
                                      bottom: 10.h,
                                      right: 15.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.h),
                                      ),
                                      border: Border.all(
                                          color: selectColor(), width: 1.h)),
                                  child: Column(children: <Widget>[
                                    Container(
                                      height: 85.h,
                                      width: 85.h,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.h)),
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "Society Name\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "Institution",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      ScreenUtil().setSp(10),
                                                  fontWeight: FontWeight.w300,
                                                )),
                                          ]),
                                    )
                                  ]));
                            })),
              ],
            );
          }
          return Padding(
              padding: EdgeInsets.only(top: 150.h),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator()));
        });
  }
}
