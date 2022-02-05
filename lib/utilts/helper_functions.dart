import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelperFunctions {
  static toast({required String text, Color backgroundColor = Colors.red}) {
    Fluttertoast.showToast(
        msg: "$text",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}