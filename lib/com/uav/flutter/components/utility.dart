import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

void showToastShortTime(BuildContext context , String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black,
      textColor: Colors.white
  );
}

void showToastLongTime(BuildContext context , String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black,
      textColor: Colors.white
  );
}

Widget appointmentListCreate(List<AppointmentListItemVO> list) {
  return list.isNotEmpty
      ? ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: Text(list[position].serviceName!),
                  onLongPress: () =>
                      showToastLongTime(context, list[position].serviceName!)
              )
            ],
          ),
        );
      })
      : Center(
    child :  Align(
      alignment: Alignment.center,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "No Appointment Found",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: UavPrimaryColor
              ),
            ),
          ),
        ),
      ),
    ),
  );
}