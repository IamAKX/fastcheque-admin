import 'package:fastcheque_admin/utils/helper_methods.dart';

import 'package:flutter/material.dart';

bool checkValidEmail(String email) {
  bool res = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!res) showToast('Invalid email format');
  return res;
}

bool checkAllMandatoryFields(List<TextEditingController> list) {
  for (TextEditingController tc in list) {
    if (tc.text.isEmpty) {
      showToast('All fields are mandatory');
      return false;
    }
  }
  return true;
}

bool checkAllEmptyString(List<String> list) {
  for (String tc in list) {
    if (tc.isEmpty) {
      showToast('All fields are mandatory');
      return false;
    }
  }
  return true;
}

bool validateChequeSequence(String sequence) {
  if (sequence.isEmpty) {
    showToast('Enter cheque seqence');
    return false;
  }
  if (sequence.length != 3) {
    showToast('Cheque seqence number should be 3 character Alphanumeric');
    return false;
  }
  return true;
}
