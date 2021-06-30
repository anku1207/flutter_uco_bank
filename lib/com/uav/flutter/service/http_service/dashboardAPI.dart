import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/dashboard_response_v_o.dart';
import 'package:http/http.dart' as http;

import 'baseurl.dart';


Future<DashboardResponseVO?> getDashboardData(String customerId) async {
  EasyLoading.show(status: 'loading...');
  print("checkDuplicateNumber_Click");
  final response = await http.get(Uri.parse(
      ApiUrl.BASE_URL + 'Dashboard/' + customerId));
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
