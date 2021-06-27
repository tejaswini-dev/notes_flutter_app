import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notes_app/resources/app_colors.dart';
import 'package:flutter_notes_app/resources/font_constants.dart';
import 'package:flutter_notes_app/resources/image_constants.dart';
import 'package:flutter_notes_app/resources/route_constants.dart';
import 'package:flutter_notes_app/utils/snackBarUtil.dart';
import 'package:flutter_notes_app/widgets/authentication.dart';
import 'package:flutter_notes_app/widgets/blue_clipper.dart';
import 'package:flutter_notes_app/widgets/inputFields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert' show json;
import "package:http/http.dart" as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /*Instance of ScreenUtil*/
  final ScreenUtil screenUtil = ScreenUtil();

  /*Text Editing Controller*/
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  bool isValidEmail = false;
  int loginType = 1;

  final String signInText = "Sign In";
  final String signInWithGoogleText = "Sign In with Google";
  final String orText = "OR";
  final String emailHintText = "Email";
  final String passwordHintText = "Password";

  /*Error Text*/
  final String emailEmptyErrorText = "Please enter your Email Address";
  final String validEmailErrorText = "Please enter valid Email Address";
  final String passwordEmptyErrorText = "Please enter your Password";
  final String invalidPasswordErrorText =
      "Your password is invalid. Please enter correct Password";
  final String passwordLengthErrorText =
      "Password should be at least 6 characters";

  @override
  void initState() {
    super.initState();
//    isLoggedIn();
  }

  isLoggedIn() async {
    User userData = await Authentication.getCurrentUser();
    if (userData != null) {
      Map<String, dynamic> data = {};
      data = {
        "user": userData,
        "loginType": loginType,
      };
      Navigator.pushNamed(
        context,
        RouteConstants.routeDashboardScreen,
        arguments: {"data": data},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            width: screenUtil.screenWidth,
            height: screenUtil.screenHeight * 0.9,
            child: ClipPath(
              clipper: BlueClipper(),
              child: Container(
                width: screenUtil.screenWidth,
                color: AppColors.darkBlueColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenUtil.setHeight(50.0),
                    ),
                    Text(
                      signInText.toUpperCase() ?? "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenUtil.setSp(30.0),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: AppFontFamily.fontRobotoMedium,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: screenUtil.setHeight(45.0),
              horizontal: screenUtil.setWidth(45.0),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenUtil.screenHeight * 0.3,
                ),
                InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus.unfocus();
                    User user = await Authentication.signInWithGoogle();
                    if (user != null) {
                      print("User: $user");
                      loginType = 2;
                      Map<String, dynamic> data = {};
                      data = {
                        "user": user,
                        "loginType": loginType,
                      };
                      Navigator.pushNamed(
                        context,
                        RouteConstants.routeDashboardScreen,
                        arguments: {"data": data},
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenUtil.setHeight(10.0),
                      horizontal: screenUtil.setWidth(15.0),
                    ),
                    width: screenUtil.screenWidth,
                    height: screenUtil.setHeight(50.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppColors.darkBlueColor,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          AppImages.googleLogo,
                          width: screenUtil.setWidth(40.0),
                          height: screenUtil.setWidth(40.0),
                        ),
                        Text(
                          signInWithGoogleText.toUpperCase() ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenUtil.setSp(18.0),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontFamily: AppFontFamily.fontRobotoMedium,
                            color: AppColors.darkBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(20.0),
                ),
                Text(
                  orText.toUpperCase() ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenUtil.setSp(20.0),
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontFamily: AppFontFamily.fontRobotoMedium,
                    color: AppColors.darkBlueColor,
                  ),
                ),
                SizedBox(
                  height: screenUtil.setHeight(20.0),
                ),
                InputsTextField(
                  hintTextData: emailHintText,
                  textEditController: emailTextController,
                  onChange: (val) {
                    isValidEmail = Authentication.isEmail(val);
                  },
                  inputformatter: [
                    /*Allows only single space*/
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                    /*Restricts emojis*/
                    FilteringTextInputFormatter.deny(RegExp(
                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                  ],
                ),
                SizedBox(
                  height: screenUtil.setHeight(20.0),
                ),
                InputsTextField(
                  hintTextData: passwordHintText,
                  obscureInputText: true,
                  textEditController: passwordTextController,
                  inputformatter: [
                    /*Allows only alphabets*/
                    FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z0-9]+|\s")),
                    /*Allows only single space*/
                    FilteringTextInputFormatter.deny(RegExp(r"\s")),
                    /*Restricts emojis*/
                    FilteringTextInputFormatter.deny(RegExp(
                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])')),
                  ],
                ),
                SizedBox(
                  height: screenUtil.setHeight(20.0),
                ),
                InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus.unfocus();
                    if (emailTextController.text.isEmpty) {
                      SnackBarHelperUtil.showSnackBar(
                        context: context,
                        message: emailEmptyErrorText ?? "",
                      );
                    } else if (emailTextController.text.isNotEmpty &&
                        isValidEmail == false) {
                      SnackBarHelperUtil.showSnackBar(
                        context: context,
                        message: validEmailErrorText ?? "",
                      );
                    } else if (passwordTextController.text.isEmpty) {
                      SnackBarHelperUtil.showSnackBar(
                        context: context,
                        message: passwordEmptyErrorText ?? "",
                      );
                    } else if (passwordTextController.text.isNotEmpty &&
                        passwordTextController.text.length < 6) {
                      SnackBarHelperUtil.showSnackBar(
                        context: context,
                        message: passwordLengthErrorText ?? "",
                      );
                    } else {
                      UserCredential userData =
                          await Authentication.signInWithEmailPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text,
                        context: context,
                      );
                      if (userData != null) {
                        loginType = 1;
                        Map<String, dynamic> data = {};
                        data = {
                          "user": userData,
                          "loginType": loginType,
                        };
                        Navigator.pushNamed(
                            context, RouteConstants.routeDashboardScreen,
                            arguments: {"data": data});
                      } else {
                        SnackBarHelperUtil.showSnackBar(
                          context: context,
                          message: invalidPasswordErrorText ?? "",
                        );
                      }
                    }
                  },
                  child: Container(
                    width: screenUtil.screenWidth,
                    height: screenUtil.setHeight(50.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColors.darkBlueColor,
                    ),
                    child: Center(
                      child: Text(
                        signInText.toUpperCase() ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenUtil.setSp(20.0),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          fontFamily: AppFontFamily.fontRobotoMedium,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
//    if (user != null) {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          ListTile(
//            leading: GoogleUserCircleAvatar(
//              identity: user,
//            ),
//            title: Text(user.displayName ?? ''),
//            subtitle: Text(user.email),
//          ),
//          const Text("Signed in successfully."),
//          Text(_contactText),
//          ElevatedButton(
//            child: const Text('SIGN OUT'),
//            onPressed: _handleSignOut,
//          ),
//          ElevatedButton(
//            child: const Text('REFRESH'),
//            onPressed: () => _handleGetContact(user),
//          ),
//        ],
//      );
//    } else {
//      return Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          const Text("You are not currently signed in."),
//          ElevatedButton(
//            child: const Text('SIGN IN'),
//            onPressed: _handleSignIn,
//          ),
//        ],
//      );
//    }
  }
}
