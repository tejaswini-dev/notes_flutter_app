import 'package:flutter/material.dart';
import 'package:flutter_notes_app/resources/route_constants.dart';
import 'package:flutter_notes_app/screens/Dashboard/DashboardScreen.dart';
import 'package:flutter_notes_app/screens/Login/LoginScreen.dart';
import 'package:flutter_notes_app/screens/SplashScreen/SplashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /*Splash Screen*/
      case RouteConstants.routeSplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;

      /*Login Screen*/
      case RouteConstants.routeLoginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;

      /*Dashboard*/
      case RouteConstants.routeDashboardScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => DashboardScreen(
                user: data['data']['user'] ?? "",
                loginType: data['data']['loginType'] ??
                    1, /*Login Type 1 - Sign In with Email and Password | 2 - Google Sign in*/
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => DashboardScreen(),
            );
          }
        }
        break;
    }
  }
}
