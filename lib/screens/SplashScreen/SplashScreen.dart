import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/resources/app_colors.dart';
import 'package:flutter_notes_app/resources/font_constants.dart';
import 'package:flutter_notes_app/resources/route_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ScreenUtil screenUtil = ScreenUtil();

  String welcomeText = "Welcome";

  @override
  void initState() {
    super.initState();
    /*Navigation to Login Screen*/
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        RouteConstants.routeLoginScreen,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenUtil.screenWidth,
        height: screenUtil.screenHeight,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: AppColors.gradientBlue,
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Text(
            welcomeText.toUpperCase() ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenUtil.setSp(30.0),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontFamily: AppFontFamily.fontRobotoMedium,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
