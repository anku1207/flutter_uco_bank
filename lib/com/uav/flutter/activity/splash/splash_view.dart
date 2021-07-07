import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';


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

          _determinePosition().then((value){
            if(value!=null){

             print(value.latitude.toString() +"==="+ value.longitude.toString());

              checkCustomerSession().then((value){
                print(value);
                if(value==false){
                  Navigator.pushReplacementNamed(context,UavRoutes.DashBoard_Screen);
                }else{
                  Navigator.pushReplacementNamed(context,UavRoutes.Login_Screen);
                }
              });
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


  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            'Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


 /* Future<LocationData?> getLocation() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _permissionGranted = await location.requestPermission();
      }
    }
    return _locationData = await location.getLocation();
  }
*/

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

