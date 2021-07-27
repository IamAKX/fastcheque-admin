import 'dart:convert';

import 'dart:html';

downloadCSV(String data) {
  String csv = 'test,test2,test3\ntest,test2,test3';
  final content = base64Encode(csv.codeUnits);
  AnchorElement(href: 'data:application/csv;base64,$content')
    ..setAttribute("download", "file.csv")
    ..click();
}
