import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_item_v_o.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';
import 'package:intl/intl.dart';

void showToastShortTime(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black,
      textColor: Colors.white);
}

void showToastLongTime(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM, // also possible "TOP" and "CENTER"
      backgroundColor: Colors.black,
      textColor: Colors.white);
}


void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar( content: Text(message), duration: Duration(milliseconds: 1000), ), );
}



DateTime StringToDate(String format , String StringDate){
  return new DateFormat(format).parse(StringDate);
}
Future<DateTime?> showDateDialog(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate:
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
      lastDate: DateTime(2101));
  if (picked != null && picked != selectedDate) return picked;
}

Map<String, dynamic> AlertDialogDesignResponseWise(String title , String message , String btnText ,bool responseStatus) {
  var dialogDesign = <String, dynamic>{};

  if(responseStatus){
    dialogDesign["H_BACKGROUND_COLOR"]=UavPrimaryColor;
    dialogDesign["H_ICON"]=Icons.check_circle_rounded;
    dialogDesign["BTN_TEXT"]=btnText;
    dialogDesign["BTN_COLOR"]=Color(0xFFB3E5FC);
    dialogDesign["BTN_BORDER_COLOR"]=UavPrimaryColor;
    dialogDesign["MESSAGE"]=message;
    dialogDesign["TITLE"]=title;
  }else{
    dialogDesign["H_BACKGROUND_COLOR"]=actions_bg_orange;
    dialogDesign["H_ICON"]=Icons.sms_failed_outlined;
    dialogDesign["BTN_TEXT"]=btnText;
    dialogDesign["BTN_COLOR"]=Color(0xFFFFCDD2);
    dialogDesign["BTN_BORDER_COLOR"]=Color(0xFFEF5350);;
    dialogDesign["MESSAGE"]=message;
    dialogDesign["TITLE"]=title;
  }

  return dialogDesign;
}
