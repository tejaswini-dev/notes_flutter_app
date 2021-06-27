import 'package:flutter/material.dart';
import 'package:flutter_notes_app/resources/app_colors.dart';
import 'package:flutter_notes_app/resources/font_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputsTextField extends StatelessWidget {
  final String hintTextData;
  final TextEditingController textEditController;
  final bool obscureInputText;
  final inputformatter;
  final Function onChange;

  const InputsTextField({
    Key key,
    this.hintTextData,
    this.textEditController,
    this.inputformatter,
    this.obscureInputText = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputformatter,
      obscureText: obscureInputText ?? false,
//      buildCounter: (
//        BuildContext context, {
//        int currentLength,
//        int maxLength,
//        bool isFocused,
//      }) {
//        return Padding(
//          padding: EdgeInsets.symmetric(
//            horizontal: ScreenUtil().setWidth(15.0),
//          ),
//          child: Align(
//            alignment: Alignment.centerLeft,
//            child: Text(
//              "${textEditController.text.length} / $maximumLength",
//              style: TextStyle(
//                color: AppColors.darkBlueColor,
//                fontWeight: FontWeight.w400,
//                fontFamily: AppFontFamily.fontRobotoRegular,
//                fontStyle: FontStyle.normal,
//                fontSize: ScreenUtil().setSp(13.0),
//              ),
//            ),
//          ),
//        );
//      },
      controller: textEditController,
      onChanged: onChange,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.darkBlueColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.darkBlueColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.darkBlueColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
              color: AppColors.darkBlueColor,
            )),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: AppColors.darkBlueColor,
          ),
        ),
        hintText: hintTextData ?? "",
        hintStyle: TextStyle(
          color: AppColors.darkBlueColor,
          fontWeight: FontWeight.w400,
          fontFamily: AppFontFamily.fontRobotoRegular,
          fontStyle: FontStyle.normal,
          fontSize: ScreenUtil().setSp(16.0),
        ),
      ),
    );
  }
}
