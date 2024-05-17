import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:techno_news/utils/form_validator_function.dart';
import 'package:techno_news/utils/helper_function.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends ChangeNotifier {
  bool showSplash = true;
  bool isLogin = false;

  void hideSplash() {
    showSplash = false;
    notifyListeners();
  }

  void init() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        isLogin = true;
      } else {
        isLogin = false;
      }
      print('herreeeeee');
      print(isLogin);
      notifyListeners();
    });
  }

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
      final id = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(id.user!.uid)
          .set({
        'full_name': fullName,
        'date_created': DateTime.now().microsecondsSinceEpoch,
        'type': 'user',
      });
    } on FirebaseAuthException catch (e) {
      firebaseAuthExceptionHandler(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (!validateLoginForm(
      email: email,
      password: password,
    )) {
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      firebaseAuthExceptionHandler(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        forceCodeForRefreshToken: true,
      ).signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final id = await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      firebaseAuthExceptionHandler(e);
    }
  }

  Future<void> continueWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status != LoginStatus.success) {
        return;
      }
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      firebaseAuthExceptionHandler(e);
    }
  }
}
