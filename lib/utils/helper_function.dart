import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void firebaseAuthExceptionHandler(e) {
  String message = "Cannot process the operation. Please try again";
  if (e.code == 'weak-password') {
    message = 'The password provided is too weak.';
  } else if (e.code == 'invalid-email') {
    message = 'The Email provided is on invalid format.';
  } else if (e.code == 'email-already-in-use') {
    message = 'The account already exists for that email.';
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
