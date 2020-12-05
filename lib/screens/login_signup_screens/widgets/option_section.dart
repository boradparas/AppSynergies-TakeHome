import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OptionSection extends StatelessWidget {
  const OptionSection({
    Key key,
    this.titleText,
    this.actionText,
    this.onPress,
    this.fontSize,
    this.paddingAround,
  }) : super(key: key);

  final String actionText;
  final double fontSize;
  final AsyncCallback onPress;
  final double paddingAround;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingAround),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titleText,
            style: const TextStyle(color: Colors.black),
          ),
          InkWell(
            onTap: onPress,
            child: Text(
              actionText,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
