import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/appointment_list_item_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/branch_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/services_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/time_slot_v_o.dart';

import 'package:http/http.dart' as http;

import 'baseurl.dart';

Future<DashboardResponseVO?> getDashboardData(String customerId) async {
  EasyLoading.show(status: 'loading...');
  print("checkDuplicateNumber_Click");
  final response =
      await http.get(Uri.parse(ApiUrl.BASE_URL + 'Dashboard/' + customerId));
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DashboardResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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

