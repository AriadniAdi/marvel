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
    apiKey: 'AIzaSyCz0HCn7_7SX1xNfcrmqyqi0MJLj7PE6hQ',
    appId: '1:49449820726:web:ceb8f85e1c5edda7f6ee97',
    messagingSenderId: '49449820726',
    projectId: 'marvel-app-maitha',
    authDomain: 'marvel-app-maitha.firebaseapp.com',
    storageBucket: 'marvel-app-maitha.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVcbIWyNQK5JgJ_tGvrVTECyjqTY2ZeGU',
    appId: '1:49449820726:android:db2599c1b5d9be70f6ee97',
    messagingSenderId: '49449820726',
    projectId: 'marvel-app-maitha',
    storageBucket: 'marvel-app-maitha.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyClS1JaiKCljADBz_B4uaRpuBDwUax6LMY',
    appId: '1:49449820726:ios:d8e4cec549d3e62bf6ee97',
    messagingSenderId: '49449820726',
    projectId: 'marvel-app-maitha',
    storageBucket: 'marvel-app-maitha.firebasestorage.app',
    iosBundleId: 'com.example.marvelApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyClS1JaiKCljADBz_B4uaRpuBDwUax6LMY',
    appId: '1:49449820726:ios:d8e4cec549d3e62bf6ee97',
    messagingSenderId: '49449820726',
    projectId: 'marvel-app-maitha',
    storageBucket: 'marvel-app-maitha.firebasestorage.app',
    iosBundleId: 'com.example.marvelApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCz0HCn7_7SX1xNfcrmqyqi0MJLj7PE6hQ',
    appId: '1:49449820726:web:3d749581f829c153f6ee97',
    messagingSenderId: '49449820726',
    projectId: 'marvel-app-maitha',
    authDomain: 'marvel-app-maitha.firebaseapp.com',
    storageBucket: 'marvel-app-maitha.firebasestorage.app',
  );

}