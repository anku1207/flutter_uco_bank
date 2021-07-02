import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin{
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
   /* animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );*/
      //animationController.repeat();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    int _start = 2;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          _timer.cancel();
          checkCustomerSession().then((value){
            print(value);
            if(value==false){
              Navigator.pushReplacementNamed(context,UavRoutes.DashBoard_Screen);
            }else{
              Navigator.pushReplacementNamed(context,UavRoutes.Login_Screen);
            }
          });
          // Navigator.pushReplacementNamed(context,BouncyPage(widget: login()))
        }else {
            _start--;
        }
      },
    );
  }
  Future<bool?> checkCustomerSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(KEY_FIRST_LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    // timer set two parameter first duration and second call back function


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

