import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import "package:flutter_uco_bank/com/uav/flutter/activity/splash/splash_view.dart";
import "package:flutter_uco_bank/com/uav/flutter/activity/registration/login.dart";


class UavRoutes {
  static const Splash_Screen = "/splash_screen";
  static const Login_Screen = "/login";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case UavRoutes.Splash_Screen:
        return MaterialPageRoute(builder: (_) => SplashView());
      case UavRoutes.Login_Screen:
        return MaterialPageRoute(builder: (_)=>login());
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
