import 'dart:convert';

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color.dart';

downloadCSV(String data) {
  String csv = 'test,test2,test3\ntest,test2,test3';
  final content = base64Encode(csv.codeUnits);
  AnchorElement(href: 'data:application/csv;base64,$content')
    ..setAttribute("download", "file.csv")
    ..click();
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: secondaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
