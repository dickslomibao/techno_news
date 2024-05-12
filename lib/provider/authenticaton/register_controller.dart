import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techno_news/utils/form_validator_function.dart';
import 'package:techno_news/utils/helper_function.dart';

class RegisterController extends ChangeNotifier {
  Future<void> createAnAccount({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (!validateRegistrationForm(
      fullName: fullName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    )) {
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      firebaseAuthExceptionHandler(e);
    } catch (e) {
      print(e);
    }
  }
}
