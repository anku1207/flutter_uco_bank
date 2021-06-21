import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
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
                    ),
                  ),
                ),
              ),
          ]),
    );
  }
}
