import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/resources/app_colors.dart';
import 'package:flutter_notes_app/resources/font_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarHelperUtil {
  static showSnackBar({BuildContext context, String message}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppFontFamily.fontRobotoRegular,
          fontSize: ScreenUtil().setSp(16.0),
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          color: AppColors.whiteColor,
        ),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.redColor,
    )..show(context);
  }
}
