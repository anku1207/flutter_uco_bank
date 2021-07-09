import 'dart:convert';

import 'package:alice/alice.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterAPI.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/services_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/time_slot_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_v_o.dart';
import 'package:flutter_uco_bank/main.dart' as main;


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../main.dart';
import 'baseurl.dart';

Future<DashboardResponseVO?> getDashboardData() async {
  EasyLoading.show(status: 'loading...');
  print("getDashboardData_Click");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response =
      await http.get(Uri.parse(ApiUrl.BASE_URL + 'Dashboard/' +  prefs.getString(KEY_CONSTOMER_ID)!));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    return DashboardResponseVO.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to Dashboard Data');
  }
}

Future<AppointmentListItemResponseVO?> getAppointment(
    String customerId, String aptTypeId) async {
  EasyLoading.show(status: 'loading...');
  print("getAppointment_Click");
  Map<String, String> queryParams = {
    'apttype': aptTypeId,
    'customerid': customerId
  };
  String queryString = Uri(queryParameters: queryParams).query;

  final response = await http.get(
      Uri.parse(ApiUrl.BASE_URL + 'Dashboard/' + "?" + queryString));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AppointmentListItemResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<BranchResponseVO?> getBranch(
    String lat, String lng) async {
  EasyLoading.show(status: 'loading...');
  print("getBranch_Click");
  Map<String, String> queryParams = {
    'lat': lat,
    'lng': lng
  };
  String queryString = Uri(queryParameters: queryParams).query;

  final response = await http.get(
      Uri.parse(ApiUrl.BASE_URL + 'Appointment/getBranch/' + "?" + queryString));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BranchResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


Future<String?> getKioskIdbyBranch(String branchId) async {
  EasyLoading.show(status: 'loading...');
  final response = await http.get(
      Uri.parse(ApiUrl.BASE_URL + 'Appointment/getKioskIdbyBranch/'+branchId));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return response.body.toString();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<ServicesResponseVO?> getServices(String branchId) async {
  EasyLoading.show(status: 'loading...');
  final response = await http.get(Uri.parse(ApiUrl.BASE_URL + 'Appointment/getServices/'+branchId));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ServicesResponseVO.fromJson(jsonDecode(response.body.toString())) ;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


Future<TimeSlotVO?> getSlotByBranchWise(
    String branchId, String selectDate) async {

  EasyLoading.show(status: 'loading...');
  final response = await http.get(
      Uri.parse(ApiUrl.BASE_URL + 'Appointment/getEmptyTimeSlot/'+ branchId +"/"+selectDate));
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return TimeSlotVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



Future<AppointmentVO?> saveAppointment(Map<String, dynamic> requestData ) async {

  EasyLoading.show(status: 'loading...');
  final response = await http.post(
    Uri.parse(ApiUrl.BASE_URL + 'Appointment/NewAppointment'),
    headers: headers,
    body: json.encode(requestData),
  );
  httpRequestDebugging(response);
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AppointmentVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to Save Appointment');
  }
}

void httpRequestDebugging(http.Response response){
  alice.onHttpResponse(response);
}

