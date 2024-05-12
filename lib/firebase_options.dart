// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBRf9ojQ-O1hCHDB8d9kmCeiha6Y5-r6bs',
    appId: '1:155073732290:ios:5098363d71f8736944e55b',
    messagingSenderId: '155073732290',
    projectId: 'technonews-744ee',
    storageBucket: 'technonews-744ee.appspot.com',
    iosBundleId: 'com.example.technoNews',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAN-DkZQl3w3ChTkUhw5imPNXTu8hHyevg',
    appId: '1:155073732290:web:94959eabcd8a0cc544e55b',
    messagingSenderId: '155073732290',
    projectId: 'technonews-744ee',
    authDomain: 'technonews-744ee.firebaseapp.com',
    storageBucket: 'technonews-744ee.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAN-DkZQl3w3ChTkUhw5imPNXTu8hHyevg',
    appId: '1:155073732290:web:94959eabcd8a0cc544e55b',
    messagingSenderId: '155073732290',
    projectId: 'technonews-744ee',
    authDomain: 'technonews-744ee.firebaseapp.com',
    storageBucket: 'technonews-744ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBRf9ojQ-O1hCHDB8d9kmCeiha6Y5-r6bs',
    appId: '1:155073732290:ios:5098363d71f8736944e55b',
    messagingSenderId: '155073732290',
    projectId: 'technonews-744ee',
    storageBucket: 'technonews-744ee.appspot.com',
    iosBundleId: 'com.example.technoNews',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqTehOTNroz1t9uSRJA87y08oLzl0Rve8',
    appId: '1:155073732290:android:58d06827d5d409ee44e55b',
    messagingSenderId: '155073732290',
    projectId: 'technonews-744ee',
    storageBucket: 'technonews-744ee.appspot.com',
  );

}