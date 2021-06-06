import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(690),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                  image: AssetImage(
                    'lib/assets/images/explore.png',
                  )),
            ),
            height: ScreenUtil().setHeight(100),
            //    color: Colors.white,
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(20),
                horizontal: ScreenUtil().setWidth(20)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'KEEP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Exploring',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(200),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(20)),
                        color: Colors.black38,
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(5)),
                              child: Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                                size: ScreenUtil().setHeight(20),
                              )),
                          Container(
                              height: ScreenUtil().setHeight(30),
                              width: ScreenUtil().setWidth(150),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(20)),
                                shape: BoxShape.rectangle,
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {},
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        //      top: ScreenUtil().setHeight(10),
                                        bottom: ScreenUtil().setHeight(10),
                                        left: ScreenUtil().setWidth(10)),
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle:
                                        TextStyle(color: Colors.white54)),
                                //       controller: _controller,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                autocorrect: true,
                                enableSuggestions: true,
                                onChanged: (value) {},
                              )),
                        ],
                      ))
                ]),
          )
        ],
      ),
    ));
  }
}
