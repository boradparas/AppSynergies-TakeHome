import 'package:flutter/material.dart';

const String kFacebookLoginV8Url = "https://www.facebook.com/v8.0/dialog/oauth";
const String kFacebookRedirectUri = "https://.firebaseapp.com/__/auth/handler";
const String kFacebookClientId = "1422079154664358";

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2),
  ),
);
