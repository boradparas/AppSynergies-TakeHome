import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSpecificProgressIndicator extends StatelessWidget {
  const PlatformSpecificProgressIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? const CircularProgressIndicator()
        : const CupertinoActivityIndicator();
  }
}
