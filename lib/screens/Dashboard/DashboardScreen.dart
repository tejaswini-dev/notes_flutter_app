import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/resources/app_colors.dart';
import 'package:flutter_notes_app/resources/font_constants.dart';
import 'package:flutter_notes_app/resources/route_constants.dart';
import 'package:flutter_notes_app/widgets/authentication.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashboardScreen extends StatefulWidget {
  final user;
  final int
      loginType; /*Login Type 1 - Sign In with Email and Password | 2 - Google Sign in*/

  const DashboardScreen({Key key, this.user, this.loginType = 1})
      : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScreenUtil screenUtil = ScreenUtil();

  final String signOutText = "Sign Out";
  final String helloText = "Hello";

  @override
  void initState() {
    super.initState();
    print("User : ${widget.user} Type: ${widget.loginType}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: AppColors.darkBlueColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenUtil.setWidth(20.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightShadowBlue,
                  radius: 20.0,
                  child: (widget.loginType == 2 &&
                          widget.user != null &&
                          widget.user?.photoURL != null)
                      ? Image.network(
                          (widget.loginType == 1)
                              ? widget.user.user.photoURL ?? ""
                              : widget.user.photoURL ?? "",
                        )
                      : Icon(
                          Icons.account_circle,
                          color: AppColors.whiteColor,
                          size: screenUtil.setSp(40.0),
                        ),
                ),
                SizedBox(
                  width: screenUtil.setWidth(15.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      helloText ?? "Hello" + widget.user?.displayName ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenUtil.setSp(14.0),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontFamily: AppFontFamily.fontRobotoMedium,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(
                      width: screenUtil.screenWidth * 0.35,
                      child: Text(
                        ((widget.loginType == 1) &&
                                widget.user?.user.email != null)
                            ? widget.user?.user.email ?? ""
                            : widget.user?.email ?? "",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: screenUtil.setSp(14.0),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: AppFontFamily.fontRobotoMedium,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenUtil.setHeight(8.0),
                horizontal: screenUtil.setWidth(10.0),
              ),
              child: InkWell(
                onTap: () async {
                  if (widget.loginType == 2) {
                    await Authentication.signOutGoogle();
                  } else {
                    await Authentication.signOut();
                  }

                  Navigator.pushNamed(
                    context,
                    RouteConstants.routeLoginScreen,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenUtil.setHeight(5.0),
                    horizontal: screenUtil.setWidth(10.0),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightShadowBlue,
                    border: Border.all(
                      color: AppColors.lightShadowBlue,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        signOutText ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenUtil.setSp(16.0),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: AppFontFamily.fontRobotoMedium,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: screenUtil.setWidth(5.0),
                      ),
                      Icon(
                        Icons.logout,
                        color: AppColors.whiteColor,
                        size: screenUtil.setSp(20.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
    );
  }
}
