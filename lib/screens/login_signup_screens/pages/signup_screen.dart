import 'package:flutter/material.dart';

import '../../../core/widgets/round_button.dart';
import '../../chat_screen/pages/chat_screen.dart';
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
        EmailSignupLogin emailSignUp = EmailSignupLogin();
        bool isSignedUp = await emailSignUp.emailSignUp(
          context,
          email: _emailTextController.text,
          password: _passwordTextController.text,
        );
        if (isSignedUp) {
          await Navigator.popAndPushNamed(context, ChatScreen.id);
        }
      }
    }
  }

  Future<void> _signUpWithFacebook() async {
    FacebookSignUpLogin(context, wantToSignUp: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
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
                RoundedButton(
                  title: 'Sign Up',
                  colour: Colors.lightBlueAccent,
                  onPressed: _signUpButtonClick,
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
                RoundedButton(
                  title: 'Continue with Facebook',
                  colour: Colors.blueAccent,
                  onPressed: _signUpWithFacebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
