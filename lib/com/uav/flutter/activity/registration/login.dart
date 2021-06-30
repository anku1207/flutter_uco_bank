import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_uco_bank/com/uav/flutter/activity/registration/register.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/BouncyPage.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/routes.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:flutter_uco_bank/com/uav/flutter/vo/login_response_v_o.dart';
import 'package:flutter_uco_bank/com/uav/flutter/service/http_service/userregisterAPI.dart'
as APICall;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  bool _isHidden = true;

  late GlobalKey<FormState> _formKey;
  late AutovalidateMode _autoValidate;
  bool mobileNumberValidate = false;

  late TextEditingController userNameId;
  late TextEditingController passwordId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autoValidate = AutovalidateMode.disabled;
    mobileNumberValidate = false;

    userNameId = new TextEditingController();
    passwordId = new TextEditingController();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
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
                                "Login",
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
                                  controller: userNameId,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counter: Offstage(),
                                    hintText: 'Enter Mobile No.',
                                    labelText: 'Enter Mobile No.',
                                    prefixIcon: const Icon(
                                      Icons.phone,
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
                                  controller: passwordId,
                                  obscureText: _isHidden,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    labelText: 'Enter Password',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    prefixText: ' ',
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(
                                        _isHidden
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
                              ])),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  // Navigator.push(context,BouncyPage(widget: register()));
                                  Navigator.pushNamed(
                                      context, UavRoutes.Forgot_Screen);
                                },
                                child: Text(
                                  "Forgot Password ?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff018ad0)),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: ElevatedButton(
                                onPressed: ()=>_submit(),
                                child: Text("LOGIN",
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    // Navigator.push(context,BouncyPage(widget: register()));
                                    Navigator.pushNamed(
                                        context, UavRoutes.register_Screen);
                                  },
                                  child: Text(
                                    "Didn\'t have account ? Register Now",
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
    );
  }
  void _submit() {
    print("_submit click function");
    var isValid = _formKey.currentState!.validate();
    if (isValid) {
      print(userNameId.text + "==" + passwordId.text );
      // hide soft keyboard
      FocusScope.of(context).requestFocus(new FocusNode());

      Future<LoginResponseVO?> response =
      APICall.login(LoginResponseVO(mobileNo:userNameId.text,password:passwordId.text ));
      response.catchError(
            (onError) {
          print(onError.toString());
          showToastShortTime(context, onError.toString());
        },
      ).then((value) {
        if (value != null) {
          if (value.isError == false) {
            if(value.isFirstLogin==false){
              Navigator.pushReplacementNamed(context, UavRoutes.DashBoard_Screen);
            }else{
              //navigation to Change Password fragment
              showToastShortTime(context,"isFirstLogin "  + value.isFirstLogin.toString());
            }

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
