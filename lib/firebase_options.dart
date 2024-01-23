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
    apiKey: 'AIzaSyBXetrTnLGygX6Bf1qXxttHuYgFpeQ2avQ',
    appId: '1:383934044020:web:61acea7ef43edbcdeffe21',
    messagingSenderId: '383934044020',
    projectId: 'traders-a32eb',
    authDomain: 'traders-a32eb.firebaseapp.com',
    storageBucket: 'traders-a32eb.appspot.com',
    measurementId: 'G-6N3V4J4MYL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx0eP_DlqxrdeY9lbGqlbE0YxvKu3HjgA',
    appId: '1:383934044020:android:2833a94d0bea2e0beffe21',
    messagingSenderId: '383934044020',
    projectId: 'traders-a32eb',
    storageBucket: 'traders-a32eb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIHS1s6sEKuZDH0r234qIB_iSQqi70O50',
    appId: '1:383934044020:ios:feac0c8584cff082effe21',
    messagingSenderId: '383934044020',
    projectId: 'traders-a32eb',
    storageBucket: 'traders-a32eb.appspot.com',
    iosBundleId: 'com.example.sme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIHS1s6sEKuZDH0r234qIB_iSQqi70O50',
    appId: '1:383934044020:ios:8e28d244e0fcf68eeffe21',
    messagingSenderId: '383934044020',
    projectId: 'traders-a32eb',
    storageBucket: 'traders-a32eb.appspot.com',
    iosBundleId: 'com.example.sme.RunnerTests',
  );
}
