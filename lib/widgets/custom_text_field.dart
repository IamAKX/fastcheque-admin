import 'package:fastcheque_admin/utils/color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController nameCtrl;
  final String hint;

  const CustomTextField({Key? key, required this.nameCtrl, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameCtrl,
      decoration: InputDecoration(
        fillColor: secondaryColor,
        filled: true,
        hintText: hint,
        labelText: hint,
        labelStyle: Theme.of(context).textTheme.subtitle1,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
