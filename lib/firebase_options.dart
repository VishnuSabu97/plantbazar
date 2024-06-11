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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBlaqX_XkVpcArIPP0zT67iZ9D06K-aSc8',
    appId: '1:458258677043:web:c46dfa5671a4373af8d246',
    messagingSenderId: '458258677043',
    projectId: 'plantbazar-6a65f',
    authDomain: 'plantbazar-6a65f.firebaseapp.com',
    storageBucket: 'plantbazar-6a65f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjEBXgZlL3KmVitwvZqDWoiPBSOGq3bw4',
    appId: '1:458258677043:android:936fa0b84d29b86ff8d246',
    messagingSenderId: '458258677043',
    projectId: 'plantbazar-6a65f',
    storageBucket: 'plantbazar-6a65f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4j3xQKwT2AVAM5cGg44ksz-HSuOFdH-4',
    appId: '1:458258677043:ios:4d65821a111fc21ef8d246',
    messagingSenderId: '458258677043',
    projectId: 'plantbazar-6a65f',
    storageBucket: 'plantbazar-6a65f.appspot.com',
    iosBundleId: 'com.example.plantbazar',
  );
}
