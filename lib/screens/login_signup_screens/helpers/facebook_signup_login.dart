import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/helpers/auth_helper.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/app_dialog.dart';
import '../../chat_screen/pages/chat_screen.dart';
import '../widgets/facebook_auth_webview.dart';

class FacebookSignUpLogin {
  FacebookSignUpLogin(this.context, {@required this.wantToSignUp}) {
    if (wantToSignUp) {
      _facebookSignUp();
    } else if (!wantToSignUp) {
      _facebookLogin();
    }
  }

  final BuildContext context;
  final bool wantToSignUp;

  Future<bool> _facebookSignUp() async {
    String result = await _resultFromFacebook();
    if (result != null) {
      try {
        final facebookAuthCred = FacebookAuthProvider.credential(result);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
        if (userCredential != null) {
          await AuthHelper.setAuthState(true);
          await Navigator.popAndPushNamed(context, ChatScreen.id);
          return true;
        } else {
          CommonDialog()
              .commomDialog(context, message: 'Please try again later.');
          return false;
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<bool> _facebookLogin() async {
    String result = await _resultFromFacebook();
    if (result != null) {
      try {
        final facebookAuthCred = FacebookAuthProvider.credential(result);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(facebookAuthCred);
        if (userCredential != null) {
          await AuthHelper.setAuthState(true);
          await Navigator.popAndPushNamed(context, ChatScreen.id);
          return true;
        } else {
          CommonDialog().commomDialog(context,
              message: 'Something went wrong please try again later.');
          return false;
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        CommonDialog().commomDialog(context,
            message: 'Something went wrong please try again later.');
        return false;
      }
    }
    return false;
  }

  Future<String> _resultFromFacebook() async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FacebookCustomWebView(
          selectedUrl:
              '$kFacebookLoginV8Url?client_id=$kFacebookClientId&redirect_uri=$kFacebookRedirectUri&response_type=token&scope=email,public_profile,',
        ),
      ),
    );
  }
}
