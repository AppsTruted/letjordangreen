import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMessage(String msg , bool isError) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor:isError ? Colors.grey : Colors.black ,      //primaryColor,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 16.0);
}
