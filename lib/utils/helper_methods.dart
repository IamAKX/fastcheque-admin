import 'dart:convert';

import 'dart:html';

import 'package:fastcheque_admin/model/manager_model.dart';
import 'package:fastcheque_admin/model/store_model.dart';
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

getChequeSequenceStringFromManager(ManagerModel manager) {
  List<String> seq = [];
  for (StoreModel model in manager.taggedStores) {
    seq.add(model.chequeSequenceNumber);
  }
  return seq.join(', ');
}

getStoreDetailOfManager(ManagerModel manager) {
  List<String> seq = [];
  for (StoreModel model in manager.taggedStores) {
    String tmp = '';
    tmp += 'Name    ${model.businessName}\n';
    tmp += 'Email     ${model.businessEmail}\n';
    tmp += 'Printer   ${model.printerEmail}\n';
    tmp += 'Seq No   ${model.chequeSequenceNumber}\n';
    tmp += 'Phone    ${model.businessPhone}\n';

    seq.add(tmp);
  }
  return seq.join('\n');
}
