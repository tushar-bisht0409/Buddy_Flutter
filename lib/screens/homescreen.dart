import 'package:buddy/main.dart';
import 'package:buddy/screens/menuscreen.dart';
import 'package:buddy/screens/searchscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:buddy/screens/feedscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              child: CircleAvatar(
                backgroundColor: acolor.primary,
                radius: ScreenUtil().setHeight(20),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: ScreenUtil().setHeight(20),
                ),
              ))
        ]));
  }
}
