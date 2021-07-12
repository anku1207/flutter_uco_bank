import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterAPI.dart';

import 'package:flutter_uco_bank/com/uav/flutter/vo/forgot_password_response_v_o.dart';


class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {

  final mobileNumberId = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;


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
                                        "Forgot Password",
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
                                              color: Color(0xff6200ee),
                                              thickness: 1)),
                                    ],
                                  )),
                              Form(
                                key: _formKey,
                                autovalidateMode: _autoValidate,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: mobileNumberId,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          counterText: "",
                                          hintText: 'Enter Mobile Number',
                                          labelText: 'Enter Mobile Number',
                                          prefixIcon: const Icon(
                                            Icons.phone_android_rounded,
                                            color: Colors.grey,
                                          ),
                                          prefixText: ' ',
                                          contentPadding: new EdgeInsets.symmetric(
                                              vertical: 20.0, horizontal: 20.0),
                                          errorMaxLines: 2),
                                      validator: (value) =>
                                          validateMobileNumber(value!),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: double.infinity),
                                  child: ElevatedButton(
                                    onPressed: ()=>forgotPasswordBtnClick(),
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

  forgotPasswordBtnClick() {
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
     // forgotPassword
      Future<ForgotPasswordResponseVO?> response = forgotPassword(mobileNumberId.text);
      response.catchError(
            (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if (value.isError == false) {
            Navigator.pushNamed(context, UavRoutes.Otp_Screen,arguments: {"mobileNumber":mobileNumberId.text,"module":FORGOT_PASSWORD});
          } else {
            showToastShortTime(context, value.message.toString());
          }
        }
      }).whenComplete(() {
        print("called when future completes");
        EasyLoading.dismiss();
      });
    }else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }
}
