
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return CupertinoPageTransitionsBuilder().buildTransitions(
    ModalRoute.of(context) as PageRoute<dynamic>,
    context,
    animation,
    secondaryAnimation,
    child,
  );
}