import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../../core/widgets/app_dialog.dart';

class EmailSignupLogin {
  // ignore: missing_return
  Future<bool> emailLogin(BuildContext context,
      {String email, String password}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        String idToken = await _auth.currentUser.getIdToken(true);
        print("---->" + idToken);
        return true;
      } else {
        CommonDialog().commomDialog(context,
            message: 'Something went wrong please try again later.');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CommonDialog()
            .commomDialog(context, message: 'No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        CommonDialog().commomDialog(context,
            message: 'Wrong password provided for that user.');
        return false;
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }

  // ignore: missing_return
  Future<bool> emailSignUp(BuildContext context,
      {String email, String password, String username}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .catchError((error) async => print(error));

      if (userCredential != null) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _auth.currentUser.updateProfile(displayName: username);
        String idToken = await userCredential.user.getIdToken(true);
      } else {
        CommonDialog().commomDialog(context,
            message: 'Something went wrong please try again later.');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonDialog().commomDialog(context,
            message: 'The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        CommonDialog().commomDialog(context,
            message: 'The account already exists for that email.');
        return false;
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
