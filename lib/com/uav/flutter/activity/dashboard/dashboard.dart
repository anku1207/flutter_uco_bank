import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/drawer_widget.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart' as DashboardAPI;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();

}



class _DashBoardState extends State<DashBoard> {
  late String userName;
  late String userEmail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName="manoj shakya";
    userEmail="manojshakya1207@gmail.com";

    Future<DashboardResponseVO?> response = DashboardAPI.getDashboardData("75");
    response.catchError(
          (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if (value.isError == false) {
          //Navigator.pushNamedAndRemoveUntil(context, UavRoutes.DashBoard_Screen,ModalRoute.withName('/'));
        } else {
          showToastShortTime(context, value.message.toString());
        }
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });




  }



  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        if (EasyLoading.isShow)
          return false;
        else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Center(child: Text('My Page!')),
        drawer: DrawerWidget(userName: userName,email: userEmail),
      ),
    );
  }
}