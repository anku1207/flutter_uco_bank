import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData theme() {
  final baseTheme = ThemeData(
      primarySwatch: Colors.blue
  );
  return baseTheme.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryDark,
    primaryColorLight: kPrimaryLight,
    accentColor: kSecondaryColor,
    bottomAppBarColor: kSecondaryDark,
    buttonColor: kSecondaryColor,


    );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: UavSecondaryColor),
    gapPadding: 5,
  );

  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    //floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //enabledBorder: enabledBorder,
    //focusedBorder: focusedBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  var baseTheme = TextTheme(
  );
  return baseTheme.copyWith(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.black),
    caption: TextStyle(color: Colors.black),
    subtitle1: TextStyle(color: Colors.black), // <-- that's the one
    headline1: TextStyle(color: Colors.black),
    headline2: TextStyle(color: Colors.black),
    headline3: TextStyle(color: Colors.black),
    headline4: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: UavPrimaryColor, // Colors.white,
   // elevation: 0,
   // brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
