import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notes_app/resources/route_constants.dart';
import 'package:flutter_notes_app/routes/locator.dart';
import 'package:flutter_notes_app/routes/navigation_service.dart';
import 'package:flutter_notes_app/routes/routing.dart';
import 'package:flutter_notes_app/screens/SplashScreen/SplashScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); /*Firebase initialization*/
  setupLocator();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String appTitleText = "Notes";

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        title: appTitleText ?? '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConstants.routeSplashScreen,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
