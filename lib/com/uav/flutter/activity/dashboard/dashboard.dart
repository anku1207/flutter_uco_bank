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
  String userName ="" ;
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<DashboardResponseVO?> response = DashboardAPI.getDashboardData("58");
    response.catchError(
          (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if (value.isError == false) {
          setState(() {
            userName=value.name!;
            userEmail=value.email!;
          });

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
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.search),
            ),
          ],
        ),
        body: Center(child: Text('My Page!')),
        drawer: DrawerWidget(userName: userName,email: userEmail),
      ),
    );
  }
}
