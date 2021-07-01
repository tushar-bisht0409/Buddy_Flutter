import 'dart:io';

import 'package:buddy/main.dart';
import 'package:buddy/screens/menuscreen.dart';
import 'package:buddy/screens/searchscreen.dart';
import 'package:buddy/widgets/addpost.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:buddy/screens/feedscreen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

var appDir;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void createDir() async {
    Directory baseDir = await getExternalStorageDirectory(); //only for Android
    // print("dir  ${baseDir.path}");
    // Directory baseDir =
    //     await getApplicationDocumentsDirectory(); //works for both iOS and Android
    // String baseDir = "/storage/emulated/0/Android/";
    String newDir = "Buddy";
    String finalDir = join(baseDir.path, newDir);
    appDir = Directory(finalDir);
    bool dirExists = await appDir.exists();
    if (!dirExists) {
      await appDir.create(recursive: true);
    }
  }

  Future<bool> _requestPermission() async {
    Permission permission = Permission.storage;
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        await _requestPermission();
      }
    }
  }

  @override
  void initState() {
    _requestPermission();
    createDir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    toppad = MediaQuery.of(context).padding.top.ceil();
    bottompad = MediaQuery.of(context).padding.bottom.ceil();
    void _onItemTapped(int index) {
      setState(() {
        homeIndex = index;
      });
    }

    List<Widget> _widgetOptions = <Widget>[
      FeedScreen(),
      SearchScreen(),
      Container(
        height: 200,
        width: 100,
        color: Colors.green,
      ),
      MenuScreen()
    ];
    return SafeArea(
        child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
          Scaffold(
            backgroundColor: Colors.white,
            body: _widgetOptions.elementAt(homeIndex),
          ),
          Positioned(
              child: Card(
                  elevation: 40,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(ScreenUtil().setWidth(35)),
                          topRight:
                              Radius.circular(ScreenUtil().setWidth(35)))),
                  child: Container(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                      height: ScreenUtil().setHeight(75),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(ScreenUtil().setWidth(35)),
                              topRight:
                                  Radius.circular(ScreenUtil().setWidth(35)))),
                      child: BottomNavigationBar(
                          selectedLabelStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: acolor.primary,
                              fontWeight: FontWeight.w300),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          items: <BottomNavigationBarItem>[
                            BottomNavigationBarItem(
                              backgroundColor: Colors.white,
                              activeIcon: Icon(
                                Icons.grid_view,
                                color: acolor.primary,
                                size: ScreenUtil().setHeight(25),
                              ),
                              icon: Icon(Icons.grid_view,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.black26),
                              label: 'Feeds',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.white,
                              activeIcon: Icon(
                                Icons.search,
                                color: acolor.primary,
                                size: ScreenUtil().setHeight(25),
                              ),
                              icon: Icon(Icons.search,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.black26),
                              label: 'Search',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.white,
                              activeIcon: Icon(
                                Icons.notifications,
                                color: acolor.primary,
                                size: ScreenUtil().setHeight(25),
                              ),
                              icon: Icon(
                                Icons.notifications,
                                size: ScreenUtil().setHeight(20),
                                color: Colors.black26,
                              ),
                              label: 'Notification',
                            ),
                            BottomNavigationBarItem(
                              backgroundColor: Colors.white,
                              activeIcon: Icon(
                                Icons.menu,
                                color: acolor.primary,
                                size: ScreenUtil().setHeight(25),
                              ),
                              icon: Icon(Icons.menu,
                                  size: ScreenUtil().setHeight(20),
                                  color: Colors.black26),
                              label: 'More',
                            ),
                          ],
                          currentIndex: homeIndex,
                          //  unselectedItemColor: Colors.white,
                          onTap: _onItemTapped)))),
          Positioned(
              bottom: ScreenUtil().setHeight(75) - ScreenUtil().setHeight(20),
              left: ScreenUtil().setWidth(180) - ScreenUtil().setHeight(20),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: acolor.primary,
                  radius: ScreenUtil().setHeight(20),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: ScreenUtil().setHeight(20),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return AddPost("", "");
                      });
                },
              ))
        ]));
  }
}
