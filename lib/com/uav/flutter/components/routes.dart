import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import "package:flutter_uco_bank/com/uav/flutter/activity/splash/splash_view.dart";
import "package:flutter_uco_bank/com/uav/flutter/activity/registration/login.dart";
import "package:flutter_uco_bank/com/uav/flutter/activity/registration/register.dart";
import "package:flutter_uco_bank/com/uav/flutter/activity/registration/forgotpassword.dart";

import 'BouncyPage.dart';


class UavRoutes {
  static const Splash_Screen = "/splash_screen";
  static const Login_Screen = "/login";
  static const register_Screen = "/register";
  static const Forgot_Screen = "/forgot";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case UavRoutes.Splash_Screen:
        return BouncyPage(widget: SplashView()); //PageRouteBuilder(pageBuilder: (_, __, ___) => SplashView());
      case UavRoutes.Login_Screen:
        return BouncyPage(widget: login()); //PageRouteBuilder(pageBuilder: (_, __, ___) =>login());
      case UavRoutes.register_Screen:
        return BouncyPage(widget: register()); //PageRouteBuilder(pageBuilder: (_, __, ___) =>register());
      case UavRoutes.Forgot_Screen:
        return BouncyPage(widget: forgotpassword());
     default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
