// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCG3q64zvyBDfglC66g9f-G07n6vCcy0xU',
    appId: '1:94816600012:web:572ba1cd2b202f7f94e769',
    messagingSenderId: '94816600012',
    projectId: 'myapp-73a7e',
    authDomain: 'myapp-73a7e.firebaseapp.com',
    storageBucket: 'myapp-73a7e.appspot.com',
    measurementId: 'G-RWXSSD1EN7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPOY3KAaaVufqY_SA9yyJJn-hQvrrmjJg',
    appId: '1:94816600012:android:a77ff60fcc15903794e769',
    messagingSenderId: '94816600012',
    projectId: 'myapp-73a7e',
    storageBucket: 'myapp-73a7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_buDnpesP8eVbcsk5ko0b8M1kbmRDReY',
    appId: '1:94816600012:ios:d1d305d82ad7ffb294e769',
    messagingSenderId: '94816600012',
    projectId: 'myapp-73a7e',
    storageBucket: 'myapp-73a7e.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB_buDnpesP8eVbcsk5ko0b8M1kbmRDReY',
    appId: '1:94816600012:ios:fa3b146b9f8d3ac894e769',
    messagingSenderId: '94816600012',
    projectId: 'myapp-73a7e',
    storageBucket: 'myapp-73a7e.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
