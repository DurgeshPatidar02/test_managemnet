import 'package:flutter/material.dart';

class AppSnackBar {
  String msg;
  Color? color;
  BuildContext context;

  AppSnackBar(Color color, {required this.msg, required this.context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }
}
