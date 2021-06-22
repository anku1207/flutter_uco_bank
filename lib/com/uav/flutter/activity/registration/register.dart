import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
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
                                          color: Color(0xff6200ee),
                                          thickness: 1)),
                                ],
                              )),
                          TextField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
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
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counter: Offstage(),
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              hintText: 'Enter Mobile Number',
                              labelText: 'Enter Mobile Number',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              prefixText: ' ',
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
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
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: double.infinity),
                              child: ElevatedButton(
                                onPressed: () {},
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
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                              )),
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
