import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/constants.dart'
    as constants;
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/registerresponse_v_o.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/duplicate_vo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterapi.dart'
    as APICall;

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final username = new TextEditingController();
  final mobileNumber = new TextEditingController();
  final emailId = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool mobileNumberValidate = false;

  void _submit() {
    print("button click function");
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      print(username.text + "==" + mobileNumber.text + "==" + emailId.text);

      Future<RegisterResponseVO?> dfd =
          APICall.register(username.text, mobileNumber.text, emailId.text);
      dfd.catchError(
        (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if (value.isError == false) {
            Navigator.pushNamed(context, UavRoutes.Otp_Screen);
          } else {
            showToastShortTime(context, value.message.toString());
          }
        }
      }).whenComplete(() {
        print("called when future completes");
        EasyLoading.dismiss();
      });
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  /*checkDuplicateNumber({required Function onTap,required String mobileNumber}){
    onTap(mobileNumber);
  }*/

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
                                  "Register",
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
                              child: Column(children: <Widget>[
                                TextFormField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Username',
                                    labelText: 'Enter Username',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    prefixText: ' ',
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                  ),
                                  validator: (value) =>
                                      validateRequiredField(value),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: mobileNumber,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      hintText: 'Enter Mobile Number',
                                      labelText: 'Enter Mobile Number',
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      prefixText: ' ',
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20.0),
                                      errorMaxLines: 2),
                                  validator: (value) =>
                                      validateMobileNumber(value!),
                                  onChanged: (valueTextInput) {
                                    if (valueTextInput.length == 10) {
                                      if (validateMobileNumber(
                                              valueTextInput) ==
                                          null) {
                                        /* checkDuplicateNumber(onTap: (String text) {
                                        showToastShortTime(context, text);
                                      },mobileNumber:value);*/
                                        Future<DuplicateVO?> dfd =
                                            APICall.checkDuplicateNumber(
                                                valueTextInput);
                                        dfd.catchError(
                                          (onError) {
                                            print(onError.toString());
                                            showToastShortTime(
                                                context, onError.toString());
                                          },
                                        ).then((value) {
                                          if (value != null) {
                                            if (value.isError == false) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                              setState(() {
                                                mobileNumberValidate = true;
                                              });
                                            } else {
                                              setState(() {
                                                mobileNumberValidate = false;
                                              });
                                              showToastShortTime(context,
                                                  value.message.toString());
                                            }
                                          } else {
                                            setState(() {
                                              mobileNumberValidate = false;
                                            });
                                          }
                                        }).whenComplete(() {
                                          print("called when future completes");
                                          EasyLoading.dismiss();
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        mobileNumberValidate = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailId,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    labelText: 'Enter Email',
                                    prefixIcon: const Icon(
                                      Icons.mail,
                                      color: Colors.grey,
                                    ),
                                    prefixText: ' ',
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'email is required'),
                                    EmailValidator(
                                        errorText:
                                            'enter a valid email address')
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        minWidth: double.infinity),
                                    child: ElevatedButton(
                                      onPressed: () => mobileNumberValidate
                                          ? _submit()
                                          : null,
                                      child: Text("Register".toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  !mobileNumberValidate
                                                      ? constants.disableColor
                                                      : constants.buttonColor),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ))),
                                    )),
                              ]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Center(
                                child: InkWell(
                                    onTap: () {
                                      // Navigator.push(context,BouncyPage(widget: register()));
                                      Navigator.pop(context, true);
                                    },
                                    child: Text(
                                      "Already registered ? Sign In",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff018ad0)),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
