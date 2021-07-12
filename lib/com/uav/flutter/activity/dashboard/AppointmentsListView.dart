import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/UiUtility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart'
    as itemVO;
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/dashboardAPI.dart'
    as DashboardAPI;
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';

class AppointmentListView extends StatefulWidget {
  final Object argument;
  const AppointmentListView({Key? key, required this.argument})
      : super(key: key);

  @override
  _AppointmentListViewState createState() => _AppointmentListViewState();
}

class _AppointmentListViewState extends State<AppointmentListView> {
  var argumentsMap;
  List<AppointmentListItemVO> myList =
      List.filled(0, AppointmentListItemVO(), growable: true);

  late String title;
  late int id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.argument != null) {
      argumentsMap = widget.argument as Map;
      print(argumentsMap);
      title = argumentsMap["title"];
      if (argumentsMap["type"] == "filter") {

        var filterData = argumentsMap["data"].split("|");
        print(filterData.toString());

        Future<AppointmentListItemResponseVO?> response =
            DashboardAPI.getFilterAppointment(
                filterData[0], filterData[1], filterData[2]);
        response.catchError(
          (onError) {
            print(onError.toString());
            showToastShortTime(context, onError.toString());
          },
        ).then((value) {
          if (value != null) {
            if (value.isError == false) {
              setState(() {
                myList.addAll(value.appointmentList!);
              });
            } else {
              showToastShortTime(context, value.message.toString());
            }
          }
        }).whenComplete(() {
          print("called when future completes");
          EasyLoading.dismiss();
        });
      } else {

        // if type is dashboard id is required
        id = argumentsMap["id"];

        Future<AppointmentListItemResponseVO?> response =
            DashboardAPI.getAppointment(id.toString());
        response.catchError(
          (onError) {
            print(onError.toString());
            showToastShortTime(context, onError.toString());
          },
        ).then((value) {
          if (value != null) {
            if (value.isError == false) {
              setState(() {
                myList.addAll(value.appointmentList!);
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
    } else {
      Navigator.pop(context, true);
    }
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
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: Text(this.title),
          ),
          body: appointmentListCreate(
              myList /*new List.filled(0, new DashboardItemVO())*/),
        ));
  }
}
