import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/default_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterAPI.dart'
    as APICall;

class otp extends StatefulWidget {
  final Object argument;
  const otp({Key? key, required this.argument}) : super(key: key);

  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<otp> {
  late Timer _timer;
  var argumentsMap;
  var resendOTPTextView = "Click to resend OTP";
  var _formKey;
  late TextEditingController otpTextView;
  late AutovalidateMode _autoValidate;

  late String mobileNumber,module;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //initialized
    _formKey = GlobalKey<FormState>();
    otpTextView = new TextEditingController();
    _autoValidate = AutovalidateMode.disabled;

    if (widget.argument != null) {
      argumentsMap = widget.argument as Map;
      print(argumentsMap);
      mobileNumber=argumentsMap["mobileNumber"];
      module=argumentsMap["module"];
      resend_OTP(argumentsMap["mobileNumber"]);
    }else{
      Navigator.pop(context, true);
    }
  }

  void resend_OTP(String mobileNumber) {
    print("resend_OTP  function");
    Future<DefaultResponseVO?> dfd = APICall.resendOTP(mobileNumber);
    dfd.catchError(
      (onError) {
        print(onError.toString());
        showToastShortTime(context, onError.toString());
      },
    ).then((value) {
      if (value != null) {
        if (value.isError == false) {
          startTimer();
        } else {
          showToastShortTime(context, value.message.toString());
        }
      }
    }).whenComplete(() {
      print("called when future completes");
      EasyLoading.dismiss();
    });
  }

  void startTimer() {
    int _start = 30;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            resendOTPTextView = "Click to resend OTP";
          });
        } else {
          setState(() {
            resendOTPTextView = "Seconds remaining: " + _start.toString();
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _submit() {
    print("button click function");
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      if(module==USER_REGISTER){
        Future<DefaultResponseVO?> response =
        APICall.verifyOtp(mobileNumber,otpTextView.text);
        response.catchError(
              (onError) {
            print(onError.toString());
            showToastShortTime(context, onError.toString());
          },
        ).then((value) {
          if (value != null) {
            if (value.isError == false) {
              Navigator.pushReplacementNamed(context, UavRoutes.Password_Screen,arguments: {"mobileNumber":mobileNumber});
            } else {
              showToastShortTime(context, value.message.toString());
            }
          }
        }).whenComplete(() {
          print("called when future completes");
          EasyLoading.dismiss();
        });
      }else{

      }

    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff018ad0),
      body: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: new Container(
                  height: 150.0,
                  width: 150.0,
                  child: new Image.asset('assets/images/uco_bank_splash.png'),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    child: SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Column(
                            children: <Widget>[
                              Text(
                                "Verification Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                  height: 20,
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: Divider(
                                      color: Color(0xff6200ee), thickness: 1)),
                            ],
                          )),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  if (resendOTPTextView ==
                                      "Click to resend OTP") {
                                    _timer.cancel();
                                    resend_OTP(argumentsMap["mobileNumber"]);
                                  }
                                },
                                child: Text(resendOTPTextView,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: redColor)),
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate,
                            child: TextFormField(
                              controller: otpTextView,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counter: Offstage(),
                                hintText: 'Enter Verification Code',
                                labelText: 'Enter Verification Code',
                                prefixIcon: const Icon(
                                  Icons.message,
                                  color: Colors.grey,
                                ),
                                prefixText: ' ',
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                              ),
                              validator: (value) =>
                                  validateRequiredField(value),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: ElevatedButton(
                                onPressed: () => _submit(),
                                child: Text("next".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xff018ad0)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
