import 'package:flutter/material.dart';
import '../../../core/widgets/round_button.dart';
import '../../chat_screen/pages/chat_screen.dart';
import '../helpers/helpers.dart';
import '../widgets/local_widgets.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  Future<void> _loginButtonClick() async {
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
      bool _emailvalid = _checkEmailValidation();
      if (_emailvalid) {
        EmailSignupLogin emailLogin = EmailSignupLogin();
        bool isSignedUp = await emailLogin.emailLogin(
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

  Future<void> _loginWithFacebook() async {
    FacebookSignUpLogin(context, wantToSignUp: false);
  }

  Future<void> _forgetPassword() async {
    setState(() {
      _emailTextController.text.isEmpty
          ? _emailValidated = true
          : _emailValidated = false;
    });
    if (_emailTextController.text.isEmpty) {
      return;
    }
    if (_checkEmailValidation()) {
      ForgetPasswordHelper forgetPasswordHelper = ForgetPasswordHelper();
      await forgetPasswordHelper.sendForgetPasswordLink(
          context, _emailTextController.text);
    }
  }

  bool _checkEmailValidation() {
    ValidationChecker validationChecker = ValidationChecker(context);
    bool _emailvalid = validationChecker.emailVerify(_emailTextController.text);
    return _emailvalid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
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
                ForgotPasswordSection(
                  onPress: _forgetPassword,
                  fontSize: 19,
                  paddingAround: 8,
                ),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: _loginButtonClick,
                ),
                OptionSection(
                  paddingAround: 8,
                  fontSize: 18,
                  actionText: "Sign Up",
                  onPress: () async {
                    await Navigator.popAndPushNamed(context, SignUpScreen.id);
                  },
                  titleText: "Don't have an account? ",
                ),
                const OrSection(),
                RoundedButton(
                  title: 'Continue with Facebook',
                  colour: Colors.blueAccent,
                  onPressed: _loginWithFacebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
