import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'com/uav/flutter/components/routes.dart';
import 'com/uav/flutter/components/theme.dart';
import "package:flutter_uco_bank/com/uav/flutter/activity/splash/splash_view.dart";
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:alice/core/alice_http_client_extensions.dart';
import 'package:alice/core/alice_http_extensions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((val) {
    runApp(MyApp());
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  });
}

Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
    darkTheme: true,
    maxCallsCount: 1000);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCO Bank',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      navigatorKey: alice.getNavigatorKey(),
      /* theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),*/
      home: SplashView(),
      // routes: routes,
      // We use routeName so that we dont need to remember the name
      // initialRoute: UavRoutes.Login,
      onGenerateRoute: RouteGenerator.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}
