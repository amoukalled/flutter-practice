import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showCustomToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
