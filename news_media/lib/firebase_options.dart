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
    apiKey: 'AIzaSyA39Dv1DoP5ahXRkVVqob_plXv-Cc51jSw',
    appId: '1:636953773414:web:2096c5add3e16fa57534a7',
    messagingSenderId: '636953773414',
    projectId: 'newstoyou-445f9',
    authDomain: 'newstoyou-445f9.firebaseapp.com',
    storageBucket: 'newstoyou-445f9.appspot.com',
    measurementId: 'G-Q8KZN813T5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_npqzei-EIYAOkxlyWJQX_urW7nKEqBQ',
    appId: '1:636953773414:android:701863b53a8f8c437534a7',
    messagingSenderId: '636953773414',
    projectId: 'newstoyou-445f9',
    storageBucket: 'newstoyou-445f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmdKdI-HUp48nRJ2CCIR6HkmLvpmWcLcY',
    appId: '1:636953773414:ios:3f68b3918e909d127534a7',
    messagingSenderId: '636953773414',
    projectId: 'newstoyou-445f9',
    storageBucket: 'newstoyou-445f9.appspot.com',
    iosBundleId: 'com.example.NewsToYou',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmdKdI-HUp48nRJ2CCIR6HkmLvpmWcLcY',
    appId: '1:636953773414:ios:fd39e98919b74a757534a7',
    messagingSenderId: '636953773414',
    projectId: 'newstoyou-445f9',
    storageBucket: 'newstoyou-445f9.appspot.com',
    iosBundleId: 'com.example.socialMediaDashboards.RunnerTests',
  );
}
