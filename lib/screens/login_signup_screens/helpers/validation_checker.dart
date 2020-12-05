import 'package:flutter/widgets.dart';

import '../../../core/widgets/app_dialog.dart';

class ValidationChecker {
  ValidationChecker(this.context);

  final BuildContext context;

  bool emailVerify(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      CommonDialog()
          .commomDialog(context, message: "Please Enter Valid Email Address.");
      return false;
    } else {
      return true;
    }
  }

  bool passwordVerify(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      CommonDialog().commomDialog(context,
          message:
              "Password should be atleast 8 characters long and contain atleast 1 Uppercase letter, 1 Lowercase letter, 1 Numeric letter and 1 special character.");
      return false;
    } else {
      return true;
    }
  }
}
