//import 'package:buddy/blocs/auth_bloc.dart';
import 'package:buddy/models/appcolor.dart';
import 'package:buddy/screens/authscreen.dart';
import 'package:buddy/screens/camerscreen.dart';
import 'package:buddy/screens/groupchatscreen.dart';
import 'package:buddy/screens/imageviewScreen.dart';
import 'package:buddy/screens/menuscreen.dart';
import 'package:buddy/screens/personchatscreen.dart';
import 'package:buddy/screens/profileinfoscreen.dart';
import 'package:buddy/screens/sandcprofilescreen.dart';
import 'package:buddy/screens/sandcscreen.dart';
import 'package:buddy/screens/searchscreen.dart';
import 'package:buddy/screens/videoviewscreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:buddy/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

int homeIndex = 0;
int toppad = 0;
int bottompad = 0;
AppColors acolor = AppColors();
String serverURl = "https://murmuring-reaches-24170.herokuapp.com";
String token;
String userID;
var dio = Dio();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return ScreenUtilInit(
        designSize: Size(360, 690),
        // allowFontScaling: false,
        builder: () => FutureBuilder(
                // Initialize FlutterFire:
                //     future: _initialization,
                builder: (context, appSnapshot) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    bottomSheetTheme: BottomSheetThemeData(
                        modalBackgroundColor: Colors.transparent,
                        backgroundColor: Colors.transparent),
                    primarySwatch: Colors.blue,
                    canvasColor: Colors.transparent,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: HomeScreen(),
                  // authResult['token'] == '' ? AuthScreen() : HomeScreen(),
                  routes: {
                    AuthScreen.routeName: (context) => AuthScreen(),
                    GroupChatScreen.routeName: (context) => GroupChatScreen(),
                    MenuScreen.routeName: (context) => MenuScreen(),
                    SandCScreen.routeName: (context) => SandCScreen(),
                    SandCProfileScreen.routeName: (context) =>
                        SandCProfileScreen(),
                    ProfileInfoScreen.routeName: (context) =>
                        ProfileInfoScreen(),
                    SearchScreen.routeName: (context) => SearchScreen(),
                    PersonChatScreen.routeName: (context) => PersonChatScreen(),
                    CameraScreen.routeName: (context) => CameraScreen(),
                    ImageViewScreen.routeName: (context) => ImageViewScreen(),
                    VideoViewScreen.routeName: (context) => VideoViewScreen(),
                  });
            }));
  }
}
