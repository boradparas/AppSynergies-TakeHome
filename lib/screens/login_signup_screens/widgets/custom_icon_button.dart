import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key key,
    this.name,
    this.onPress,
    this.color,
    this.iconData,
    this.paddingAround,
  }) : super(key: key);

  final Color color;

  final IconData iconData;
  final String name;
  final AsyncCallback onPress;
  final double paddingAround;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingAround),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              spreadRadius: 1,
              offset: Offset(
                0,
                1,
              ),
            ),
          ],
        ),
        child: FlatButton.icon(
          padding: const EdgeInsets.symmetric(vertical: 4),
          textColor: Colors.white,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          icon: IconButton(
            // icon: Image.asset(
            //   iconImageAssetPath,
            // ),
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          onPressed: onPress,
          label: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
