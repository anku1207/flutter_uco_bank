import 'package:flutter/cupertino.dart';

class BouncyPage extends PageRouteBuilder{
  final Widget widget;
  BouncyPage({required this.widget}) : super(
      pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 500),
  );
}