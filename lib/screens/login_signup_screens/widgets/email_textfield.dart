import 'package:flutter/material.dart';

class EmailSection extends StatelessWidget {
  const EmailSection({
    Key key,
    this.emailTextController,
    this.validator,
    this.fontSize,
    this.paddingAround,
  }) : super(key: key);

  final TextEditingController emailTextController;
  final double fontSize;
  final double paddingAround;
  final bool validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingAround),
      child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Email",
              style: TextStyle(fontSize: 14),
            ),
          ),
          TextFormField(
            controller: emailTextController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorText: validator ? "Email Can't Be Empty" : null,
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              hintText: 'Email',
            ),
          ),
        ],
      ),
    );
  }
}
