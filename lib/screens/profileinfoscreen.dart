import 'package:buddy/blocs/saveinfo_bloc.dart';
import 'package:buddy/main.dart';
import 'package:buddy/models/saveInfo.dart';
import 'package:buddy/screens/authscreen.dart';
import 'package:buddy/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dropdownfield/dropdownfield.dart';

class ProfileInfoScreen extends StatefulWidget {
  static const routeName = '/profileinfo_screen';
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  bool _isLoading = false;
  var iurl;
  List<String> statelist = []; //statecity.keys.toList();
  List<String> citylist = [];
  List<String> rolelist = [];

  final info = SaveInfo();
  final saveinfoBloc = SaveInfoBloc();

  final GlobalKey<FormState> _formKey = GlobalKey();
  var exe = true;
  String startyear = '2021';
  TextEditingController institute = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController uname = TextEditingController();
  @override
  void dispose() {
    saveinfoBloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    File _image;
    var picker = ImagePicker();

    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
          stream: saveinfoBloc.saveinfoStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    useRootNavigator: true,
                    builder: (context) => AlertDialog(
                      title: Text('An Error Occurred!'),
                      content: Text('Something Went Wrong, Try Again'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        )
                      ],
                    ),
                  );
                });
              }
            }
            return ListView(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          size: ScreenUtil().setWidth(25),
                          color: Colors.grey,
                        ),
                        Text(
                          'My Profile',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil().setSp(18)),
                        )
                      ]),
                    )),
                Center(
                    child: Column(children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: ScreenUtil().setWidth(60),
                      backgroundImage:
                          //(user.imageUrl != null && user.imageUrl != '')
                          //    ? NetworkImage(
                          //      user.imageUrl,
                          //   )
                          // :
                          (AssetImage(
                        'lib/assets/images/bg.png',
                      ))),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                child: Container(
                                    height: 350.0,
                                    width: 200.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Column(
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Container(height: 150.0),
                                            Container(
                                              height: 100.0,
                                              decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(30.0),
                                                  topRight:
                                                      Radius.circular(30.0),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                top: 50.0,
                                                left: 94.0,
                                                child: CircleAvatar(
                                                  radius: 45,
                                                  backgroundColor: Colors.white,
                                                  child: Container(
                                                    height: 90.0,
                                                    width: 90.0,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45.0),
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            style: BorderStyle
                                                                .solid,
                                                            width: 2.0),
                                                        image: DecorationImage(
                                                            image:
                                                                //(user.imageUrl !=
                                                                //          null &&
                                                                //    user.imageUrl !=
                                                                //      '')
                                                                // ? NetworkImage(
                                                                //   user.imageUrl,
                                                                //  )
                                                                //:
                                                                (AssetImage(
                                                              'lib/assets/images/bg.png',
                                                            )),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ))
                                          ],
                                        ),
                                        SizedBox(height: 30.0),
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            var image = await picker.getImage(
                                                source: ImageSource.camera);
                                            if (mounted) {
                                              setState(() {
                                                if (image != null) {
                                                  _image = File(image.path);
                                                  //   profile.getimageUrl(_image);
                                                }
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.deepPurple),
                                                  child: Icon(
                                                    Icons.camera,
                                                    size: 20,
                                                    color: Colors.white,
                                                  )),
                                              SizedBox(width: 8),
                                              Text('Take Photo',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.deepPurple)),
                                            ],
                                          ),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () async {
                                            var image = await picker.getImage(
                                                source: ImageSource.gallery);
                                            if (mounted) {
                                              setState(() {
                                                if (image != null) {
                                                  _image = File(image.path);
                                                  //      profile.getimageUrl(_image);
                                                }
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.deepPurple),
                                                  child: Icon(
                                                    Icons.arrow_upward,
                                                    size: 20,
                                                    color: Colors.white,
                                                  )),
                                              SizedBox(width: 8),
                                              Text('Upload Photo',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.deepPurple)),
                                            ],
                                          ),
                                        ),
                                        // user.imageUrl != null && user.imageUrl != ''
                                        //     ? SimpleDialogOption(
                                        //         onPressed: user.imageUrl != null &&
                                        //                 user.imageUrl != ''
                                        //             ? () {
                                        //                 if (mounted) {
                                        //                   setState(() {
                                        //                     profile.getimageUrl(
                                        //                         null, true);
                                        //                     Navigator.pop(context);
                                        //                   });
                                        //                 }
                                        //               }
                                        //             : null,
                                        //         child: Row(
                                        //           children: [
                                        //             Container(
                                        //                 height: 35,
                                        //                 width: 35,
                                        //                 decoration: BoxDecoration(
                                        //                     shape: BoxShape.circle,
                                        //                     color: user.imageUrl !=
                                        //                                 null &&
                                        //                             user.imageUrl !=
                                        //                                 ''
                                        //                         ? Colors.deepPurple
                                        //                         : Colors.grey),
                                        //                 child: Icon(
                                        //                   Icons.cancel,
                                        //                   size: 20,
                                        //                   color: Colors.white,
                                        //                 )),
                                        //             SizedBox(width: 8),
                                        //             Text('Remove Photo',
                                        //                 style: TextStyle(
                                        //                     color: user.imageUrl !=
                                        //                                 null &&
                                        //                             user.imageUrl !=
                                        //                                 ''
                                        //                         ? Colors.deepPurple
                                        //                         : Colors.grey[800])),
                                        //           ],
                                        //         ),
                                        //       )
                                        //     : SizedBox(
                                        //         height: 0,
                                        //         width: 0,
                                        //       ),
                                      ],
                                    ))));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(2),
                            bottom: ScreenUtil().setHeight(2),
                            right: ScreenUtil().setWidth(8),
                            left: ScreenUtil().setWidth(8)),
                        color: Colors.black45,
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                right: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(40)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(280),
                                      //     height: ScreenUtil().setHeight(35),
                                      child: Center(
                                          child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        controller: uname,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please Enter your Name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    ScreenUtil().setWidth(30)),
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    ScreenUtil().setWidth(30)),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            contentPadding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(3),
                                                bottom:
                                                    ScreenUtil().setHeight(3),
                                                left:
                                                    ScreenUtil().setWidth(20)),
                                            hintText: 'Your Name',
                                            // fillColor: Colors.deepPurple[100],
                                            focusColor: Colors.deepPurple,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        ScreenUtil().setWidth(30)),
                                                borderSide: BorderSide(color: Colors.deepPurple)),
                                            hintStyle: TextStyle(color: Colors.grey[400]),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)), borderSide: BorderSide(color: Colors.grey))),
                                        keyboardType: TextInputType.name,
                                        onSaved: (value) {
                                          if (mounted) {
                                            setState(() {
                                              //  user.userName = value;
                                            });
                                          }
                                        },
                                      )))
                                ])),
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                right: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(40)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Institution',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Container(
                                      width: ScreenUtil().setWidth(280),
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(20)),
                                      child: DropDownField(
                                        controller: institute,
                                        strict: false,
                                        //    value: user.category,
                                        icon: null,
                                        required: true,
                                        hintText: 'Your Institution',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
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
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                right: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(40)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Course/Degree',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Container(
                                      width: ScreenUtil().setWidth(280),
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(20)),
                                      child: DropDownField(
                                        controller: course,
                                        strict: false,
                                        //    value: user.category,
                                        icon: null,
                                        required: true,
                                        hintText: 'Your Course',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
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
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                right: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(40)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Branch/Trade/Subject',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Container(
                                      width: ScreenUtil().setWidth(280),
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(20)),
                                      child: DropDownField(
                                        controller: subject,
                                        strict: false,
                                        //    value: user.category,
                                        icon: null,
                                        required: true,
                                        hintText: 'Your Subject',
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
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
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(30),
                                right: ScreenUtil().setWidth(40),
                                left: ScreenUtil().setWidth(40)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Starting year of your Course/Degree',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setWidth(20),
                                          vertical: ScreenUtil().setHeight(10)),
                                      width: ScreenUtil().setWidth(280),
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(20),
                                              right:
                                                  ScreenUtil().setWidth(130)),
                                          padding: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(20),
                                            //  right: ScreenUtil().setWidth(150)
                                          ),
                                          // width: ScreenUtil().setWidth(60),
                                          color: Colors.grey[200],
                                          child: DropdownButton<String>(
                                            value: startyear,
                                            icon: const Icon(
                                                Icons.arrow_downward_rounded),
                                            iconSize: 0,
                                            elevation: 0,
                                            dropdownColor: acolor.secondary,
                                            style: const TextStyle(
                                                color: Colors.black),
                                            underline: Container(
                                              height: 0,
                                            ),
                                            onChanged: (String newValue) {
                                              setState(() {
                                                startyear = newValue;
                                              });
                                            },
                                            items: <String>[
                                              '2017',
                                              '2018',
                                              '2019',
                                              '2020',
                                              '2021'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          )))
                                ])),
                      ])),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          bottom: ScreenUtil().setHeight(30),
                          right: ScreenUtil().setWidth(60),
                          left: ScreenUtil().setWidth(60)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            authMode != AuthMode.Signup
                                ? TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'Discard',
                                        style: TextStyle(
                                            color: Colors.blueGrey[700]),
                                      )),
                                      width: ScreenUtil().setWidth(80),
                                      height: ScreenUtil().setHeight(35),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(35))),
                                    ))
                                : SizedBox(
                                    height: 0,
                                  ),
                            (_isLoading)
                                ? CircularProgressIndicator()
                                : TextButton(
                                    onPressed: () async {
                                      if (mounted) {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                      }
                                      info.name = uname.text;
                                      info.institution = institute.text;
                                      info.course = course.text;
                                      info.subject = subject.text;
                                      info.startYear = startyear;
                                      if (_formKey.currentState.validate()) {
                                        saveinfoBloc.eventSink.add(info);
                                      }
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text(
                                        'Save',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                      width: ScreenUtil().setWidth(80),
                                      height: ScreenUtil().setHeight(35),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[600],
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(35))),
                                    ))
                          ])),
                ]))
              ],
            );
          }),
    ));
  }
}
