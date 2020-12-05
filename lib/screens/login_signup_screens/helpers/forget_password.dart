import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../core/widgets/app_dialog.dart';

class ForgetPasswordHelper {
  Future<void> sendForgetPasswordLink(
      BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CommonDialog().commomDialog(context,
          message: "Check you inbox to reset password link");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommonDialog().commomDialog(context,
            message:
                'No user found for that email. Please check your email address again.');
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (exception) {
      CommonDialog().commomDialog(context, message: "Something went wrong");
    }
  }
}
