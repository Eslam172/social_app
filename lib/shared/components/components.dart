import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> ShowSuccessToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);

Future<bool?> ShowErrorToast(String msg) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);

Future navigateAndFinish(context , Widget screen) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => screen, maintainState: true),
        (Route<dynamic> route) => false);

Future navigateTo(context , Widget screen) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => screen),
);