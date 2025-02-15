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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC4uv4MJrOiDQ22dyvLaT77ByhXtXNl5EY',
    appId: '1:419173628101:web:dd4710fb2e6ce390fd18ac',
    messagingSenderId: '419173628101',
    projectId: 'kdserve-837ff',
    authDomain: 'kdserve-837ff.firebaseapp.com',
    storageBucket: 'kdserve-837ff.firebasestorage.app',
    measurementId: 'G-P04F9RW043',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBlr4V6mQKTjRRJ-poxHQJCWMHEoj4Btgg',
    appId: '1:419173628101:android:31d22cda4b0083dcfd18ac',
    messagingSenderId: '419173628101',
    projectId: 'kdserve-837ff',
    storageBucket: 'kdserve-837ff.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJFtU-Wtp3P_Ms3ZGiLXvvcyI88hjjnDo',
    appId: '1:419173628101:ios:40e1d7d4df19a376fd18ac',
    messagingSenderId: '419173628101',
    projectId: 'kdserve-837ff',
    storageBucket: 'kdserve-837ff.firebasestorage.app',
    iosBundleId: 'com.example.foodDeliveryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJFtU-Wtp3P_Ms3ZGiLXvvcyI88hjjnDo',
    appId: '1:419173628101:ios:40e1d7d4df19a376fd18ac',
    messagingSenderId: '419173628101',
    projectId: 'kdserve-837ff',
    storageBucket: 'kdserve-837ff.firebasestorage.app',
    iosBundleId: 'com.example.foodDeliveryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4uv4MJrOiDQ22dyvLaT77ByhXtXNl5EY',
    appId: '1:419173628101:web:891228c9eb3eaaf5fd18ac',
    messagingSenderId: '419173628101',
    projectId: 'kdserve-837ff',
    authDomain: 'kdserve-837ff.firebaseapp.com',
    storageBucket: 'kdserve-837ff.firebasestorage.app',
    measurementId: 'G-RR63GR4G5L',
  );
}
