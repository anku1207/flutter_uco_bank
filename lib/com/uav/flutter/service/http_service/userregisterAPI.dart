import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/change_password_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/default_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/login_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/registerresponse_v_o.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/duplicate_vo.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/baseurl.dart';


Map<String,String> headers = {'Content-Type':'application/json'};


Future<DuplicateVO?> checkDuplicateNumber(String mobileNumber) async {
  EasyLoading.show(status: 'loading...');
  print("checkDuplicateNumber_Click");
  final response = await http.get(Uri.parse(
      ApiUrl.BASE_URL + 'Account/isDuplicateMobileNo/' + mobileNumber));
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DuplicateVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<RegisterResponseVO> register(RegisterResponseVO registerResponseVO) async {
  EasyLoading.show(status: 'loading...');
  print(json.encode(registerResponseVO.toJson()));  final response = await http.post(
    Uri.parse(ApiUrl.BASE_URL + 'Account/Register'),
    headers: headers,
    body: json.encode(registerResponseVO.toJson()),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return RegisterResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<DefaultResponseVO?> resendOTP(String mobileNumber) async {
  EasyLoading.show(status: 'loading...');
  print("checkDuplicateNumber_Click");
  final response = await http.get(Uri.parse(
      ApiUrl.BASE_URL + 'Account/ResendOTP/' + mobileNumber));
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DefaultResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<DefaultResponseVO?> verifyOtp(String mobileNumber , String otp) async {
  EasyLoading.show(status: 'loading...');
  print("VerifyOtp_Click");
  final response = await http.post(
    Uri.parse(ApiUrl.BASE_URL + 'Account/VerifyOTP'),
    headers:headers,
    body: jsonEncode(<String, String>{
      'MobileNo': mobileNumber,
      'OTP': otp,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return DefaultResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<ChangePasswordResponseVO?> changePwd(ChangePasswordResponseVO changePasswordResponseVO) async {
  EasyLoading.show(status: 'loading...');
  print(json.encode(changePasswordResponseVO.toJson()));
  final response = await http.post(
    Uri.parse(ApiUrl.BASE_URL + 'Account/ChangePassword'),
    headers:headers,
    body: json.encode(changePasswordResponseVO.toJson()),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ChangePasswordResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


Future<LoginResponseVO?> login(LoginResponseVO loginResponseVO) async {
  EasyLoading.show(status: 'loading...');
  print(json.encode(loginResponseVO.toJson()));
  final response = await http.post(
    Uri.parse(ApiUrl.BASE_URL + 'Account/Login'),
    headers:headers,
    body: json.encode(loginResponseVO.toJson()),
  );
  print(response.body);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return LoginResponseVO.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}