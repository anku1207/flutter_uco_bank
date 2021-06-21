import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
   /* animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );*/
      //animationController.repeat();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // timer set two parameter first duration and second call back function
    Timer(
        Duration(
            seconds: 3
        ),() => Navigator.pushReplacementNamed(context,UavRoutes.Login_Screen)
               // Navigator.pushReplacementNamed(context,BouncyPage(widget: login()))
    );
    return new Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: new Container(
        height: 150.0,
        width: 150.0,
        child: new Image.asset('assets/images/uco_bank_splash.png'),
      ),

      /*child: AnimatedBuilder(
        animation: animationController,

        child: new Container(
          height: 150.0,
          width: 150.0,
          child: new Image.asset('assets/images/uco_bank_splash.png'),
        ),
        builder: (BuildContext context, Widget? _widget) {
            return new Transform.rotate(
                angle: animationController.value * 6.3,
                child: _widget
            );
          },

      ),*/
    );;
  }
}

