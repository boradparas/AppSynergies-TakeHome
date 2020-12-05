import 'package:flutter/material.dart';

class OrSection extends StatelessWidget {
  const OrSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Divider(
              thickness: 2,
            ),
          ),
        ),
        Text(
          "OR",
          style: TextStyle(fontSize: 14),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Divider(
              thickness: 2,
            ),
          ),
        ),
      ],
    );
  }
}
