import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../core/widgets/app_progress_indicator.dart';
import '../helpers/helpers.dart';
import '../widgets/local_widgets.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);
  static const String id = 'signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  bool _emailValidated = false;
  bool _loading = false;

  final TextEditingController _passwordTextController = TextEditingController();
  bool _passwordValidated = false;

  @override
  void dispose() {
    super.dispose();

    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  Future<void> _signUpButtonClick() async {
    setState(() {
      _emailTextController.text.isEmpty
          ? _emailValidated = true
          : _emailValidated = false;
      _passwordTextController.text.isEmpty
          ? _passwordValidated = true
          : _passwordValidated = false;
    });
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
      return;
    } else {
      ValidationChecker validationChecker = ValidationChecker(context);
      bool _emailvalid =
          validationChecker.emailVerify(_emailTextController.text);
      bool _passwordValid =
          validationChecker.passwordVerify(_passwordTextController.text);
      if (_emailvalid && _passwordValid) {
        _isLoading(true);
        EmailSignupLogin emailSignUp = EmailSignupLogin();
        await emailSignUp.emailSignUp(
          context,
          email: _emailTextController.text,
          password: _passwordTextController.text,
        );
        _isLoading(false);
      }
    }
  }

  Future<void> _signUpWithFacebook() async {
    FacebookSignUpLogin(context, wantToSignUp: true);
  }

  void _isLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: const PlatformSpecificProgressIndicator(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: <Widget>[
              EmailSection(
                paddingAround: 6,
                emailTextController: _emailTextController,
                validator: _emailValidated,
                fontSize: 28,
              ),
              PasswordSection(
                passwordTextController: _passwordTextController,
                validator: _passwordValidated,
                fontSize: 18,
                paddingAround: 18,
              ),
              CustomIconButton(
                paddingAround: Platform.isAndroid ? 7 : 1,
                color: Colors.blue,
                iconData: Icons.login,
                name: "Sign Up",
                onPress: _signUpButtonClick,
              ),
              OptionSection(
                paddingAround: 8,
                actionText: "Sign In",
                fontSize: 18,
                onPress: () async {
                  await Navigator.popAndPushNamed(context, LoginScreen.id);
                },
                titleText: "Already have an account? ",
              ),
              const OrSection(),
              CustomIconButton(
                paddingAround: Platform.isAndroid ? 7 : 1,
                color: Colors.blue,
                iconData: Icons.login,
                name: "Continue with facebook",
                onPress: _signUpWithFacebook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
