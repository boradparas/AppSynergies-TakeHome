import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDialog {
  void commomDialog(BuildContext context, {String message}) {
    showDialog(
      context: context,
      builder: (_) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay"),
              ),
            ],
          );
        } else if (Platform.isAndroid) {
          return AlertDialog(
            title: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Okay"),
              ),
            ],
          );
        }
        return null;
      },
    );
  }
}
