import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/change_password_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterapi.dart'
as APICall;

class changepassword extends StatefulWidget {
  final Object argument;
  const changepassword({Key? key, required this.argument}) : super(key: key);

  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<changepassword> {
  bool _isHiddenPassword = true, _isHiddenConfirm = true;
  var argumentsMap;
  late String mobileNumber;
  var _formKey;
  late AutovalidateMode _autoValidate;
  late TextEditingController  passwordId ;
  late TextEditingController confirmPasswordId ;

  void _togglePasswordView(String type) {
    if (type == "password") {
      setState(() {
        _isHiddenPassword = !_isHiddenPassword;
      });
    } else if (type == "confirmpassword") {
      setState(() {
        _isHiddenConfirm = !_isHiddenConfirm;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _formKey = GlobalKey<FormState>();
    _autoValidate = AutovalidateMode.disabled;
    passwordId = new TextEditingController();
    confirmPasswordId = new TextEditingController();

    if (widget.argument != null) {
      argumentsMap = widget.argument as Map;
      print(argumentsMap);
      mobileNumber = argumentsMap["mobileNumber"];
    } else {
      Navigator.pop(context, true);
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
                                      color: Color(0xff6200ee), thickness: 1)),
                            ],
                          )),
                          Form(
                              key: _formKey,
                              autovalidateMode: _autoValidate,
                              child: Column(children: <Widget>[
                                TextFormField(
                                  controller: passwordId,
                                  obscureText: _isHiddenPassword,
                                  decoration: InputDecoration(
                                    hintText: 'Enter New Password',
                                    labelText: 'Enter New Password',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    prefixText: ' ',
                                    suffixIcon: InkWell(
                                      onTap: () =>
                                          _togglePasswordView("password"),
                                      child: Icon(
                                        _isHiddenPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                    ),
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
                                  controller: confirmPasswordId,
                                  obscureText: _isHiddenConfirm,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Confirm Password',
                                    labelText: 'Enter Confirm Password',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    prefixText: ' ',
                                    suffixIcon: InkWell(
                                      onTap: () => _togglePasswordView(
                                          "confirmpassword"),
                                      child: Icon(
                                        _isHiddenConfirm
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),

                                    ),
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 20.0),
                                  ),
                                  validator: (value) {
                                    if (validateRequiredField(value)!=null) {
                                      return validateRequiredField(value);
                                    }else if(passwordId.text.isNotEmpty && passwordId.text!=value){
                                      return "New password and confirm password doesn't match";
                                    }else{
                                      return null;
                                    }
                                  },
                                ),
                              ])),
                          SizedBox(
                            height: 20,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: ElevatedButton(
                                onPressed:()=>confirmPasswordClick(),
                                child: Text("Confirm".toUpperCase(),
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

  confirmPasswordClick() {
    print("button click function");
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      Future<ChangePasswordResponseVO?> response = APICall.changePwd(mobileNumber,passwordId.text,confirmPasswordId.text);
      response.catchError(
            (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if (value.isError == false) {
            Navigator.pushReplacementNamed(context, UavRoutes.DashBoard_Screen);
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
}
