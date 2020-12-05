import 'package:flutter/material.dart';

import 'screens/chat_screen/pages/chat_screen.dart';
import 'screens/login_signup_screens/pages/login_screen.dart';
import 'screens/login_signup_screens/pages/signup_screen.dart';
import 'screens/welcome_screen/pages/welcome_screen.dart';

void main() => runApp(const AppSynergiesChat());

class AppSynergiesChat extends StatelessWidget {
  const AppSynergiesChat({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
