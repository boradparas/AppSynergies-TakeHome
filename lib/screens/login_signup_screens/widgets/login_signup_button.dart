import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginSignUpButton extends StatelessWidget {
  const LoginSignUpButton({
    Key key,
    this.name,
    this.onPress,
    this.color,
    this.padding,
    this.fontSize,
    this.paddingAround,
  }) : super(key: key);

  final Color color;
  final double fontSize;
  final String name;
  final AsyncCallback onPress;
  final double padding;
  final double paddingAround;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingAround),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: FlatButton(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: onPress,
              child: Padding(
                padding: EdgeInsets.only(
                  top: padding,
                  bottom: padding,
                ),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
