import 'package:flutter/material.dart';

class PasswordSection extends StatefulWidget {
  const PasswordSection({
    Key key,
    this.passwordTextController,
    this.validator,
    this.fontSize,
    this.paddingAround,
  }) : super(key: key);

  final double fontSize;
  final double paddingAround;
  final TextEditingController passwordTextController;
  final bool validator;

  @override
  _PasswordSectionState createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.paddingAround),
      child: Column(
        children: <Widget>[
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Password",
              style: TextStyle(fontSize: 14),
            ),
          ),
          TextFormField(
            controller: widget.passwordTextController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              errorText: widget.validator ? "Password Can't Be Empty" : null,
              contentPadding: const EdgeInsets.only(
                left: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              hintText: 'Password',
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.remove_red_eye,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
