import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/Validations.dart';
import 'package:flutter_uco_bank/com/uav/flutter/components/utility.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_uco_bank/com/uav/flutter/vo/duplicate_vo.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';




class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  var _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  void _submit() {
    var isValid = _formKey.currentState!.validate();
    if (isValid) {

    }else{
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  /*checkDuplicateNumber({required Function onTap,required String mobileNumber}){
    onTap(mobileNumber);
  }*/

  Future<DuplicateVO?> checkDuplicateNumber(String mobileNumber) async {

    try{
      print("response");
      final response =await http.get(Uri.parse('http://192.168.3.121:8986/api/Account/isDuplicateMobileNo/'+mobileNumber));
      print(response.body);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return DuplicateVO.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }catch(error){
      EasyLoading.dismiss();
      return null;
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
                                      color: Color(0xff6200ee), thickness: 1)),
                            ],
                          )),

                          Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate,
                            child: Column(children: <Widget>[
                              TextFormField(
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
                                validator: (value)=>validateRequiredField(value),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
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
                                  errorMaxLines: 2
                                ),
                                validator:(value)=> validateMobileNumber(value!),
                                onChanged: (value){
                                  if(value.length==10){
                                    if(validateMobileNumber(value)==null){
                                     /* checkDuplicateNumber(onTap: (String text) {
                                        showToastShortTime(context, text);
                                      },mobileNumber:value);*/
                                      EasyLoading.show(status: 'loading...');
                                      Future<DuplicateVO?> dfd = checkDuplicateNumber(value);
                                      dfd.then((value) =>"" );



                                    }

                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
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
                                  RequiredValidator(errorText: 'email is required'),
                                  EmailValidator(errorText:'enter a valid email address')
                                ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      minWidth: double.infinity),
                                  child: ElevatedButton(
                                    onPressed:()=> _submit,
                                    child: Text("Register".toUpperCase(),
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
    );
  }
}
