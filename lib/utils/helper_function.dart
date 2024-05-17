import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void firebaseAuthExceptionHandler(e) {
  print(e.code);
  print('asdasda');
  String message = "Cannot process the operation. Please try again";
  if (e.code == 'weak-password') {
    message = 'The password provided is too weak.';
  } else if (e.code == 'invalid-email') {
    message = 'The Email provided is on invalid format.';
  } else if (e.code == 'email-already-in-use') {
    message = 'The account already exists for that email.';
  } else if (e.code == 'account-exists-with-different-credential') {
    message = 'The account already exists with other social.';
  } else if (e.code == 'user-disabled') {
    message = 'The account has been disabled. Please contact administrator';
  } else if (e.code == 'user-not-found') {
    message = 'Your email provided is not found.';
  } else if (e.code == 'wrong-password') {
    message = 'Your Password is incorrect.';
  } else if (e.code == 'invalid-credential') {
    message = 'Your given credential is invalid.';
  } else if (e.code == 'too-many-requests') {
    message = 'Too many request. Please try again letter';
  }
  handleToastError(message);
}

void handleToastError(message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
