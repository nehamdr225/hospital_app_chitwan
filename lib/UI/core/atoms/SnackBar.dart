import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

buildAndShowSnackBar(context, content) {
  final snack = SnackBar(
    content: Text(content,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    backgroundColor: Theme.of(context).colorScheme.secondary,
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        Scaffold.of(context).hideCurrentSnackBar();
      },
    ),
  );
  Scaffold.of(context).showSnackBar(snack);
}

Future<dynamic> buildAndShowFlushBar(
    {BuildContext context, Color backgroundColor, String text, IconData icon}) {
  final flush = Flushbar(
    duration: Duration(seconds: 3),
    backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
    message: text,
    animationDuration: const Duration(milliseconds: 500),
    icon: Icon(
      icon,
      color: Colors.white,
    ),
  );
  return flush.show(context);
}
