import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({
    Key key,
    this.onPress,
    this.fontSize,
    this.paddingAround,
  }) : super(key: key);

  final double fontSize;
  final AsyncCallback onPress;
  final double paddingAround;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingAround),
      child: InkWell(
        onTap: onPress,
        child: Text(
          "Forgot password?",
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
