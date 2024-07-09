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
    apiKey: 'AIzaSyBlzdzspQooTjfQujlcTFs2C1gqj4-yMZs',
    appId: '1:598480896445:web:098f8fa646abb4ce7512d4',
    messagingSenderId: '598480896445',
    projectId: 'emo-app-3133d',
    authDomain: 'emo-app-3133d.firebaseapp.com',
    storageBucket: 'emo-app-3133d.appspot.com',
    measurementId: 'G-CF2VBN9BJ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBZ5-6denVE0eO6ubc7O_mTggs94WDMCAI',
    appId: '1:598480896445:android:ea2330ba4f43b5397512d4',
    messagingSenderId: '598480896445',
    projectId: 'emo-app-3133d',
    storageBucket: 'emo-app-3133d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWyiYewza16GmRyLe_ODidxVAuIipgmcc',
    appId: '1:598480896445:ios:558787df386c5d997512d4',
    messagingSenderId: '598480896445',
    projectId: 'emo-app-3133d',
    storageBucket: 'emo-app-3133d.appspot.com',
    androidClientId:
        '598480896445-6kdqpracans69l3f39bfoemd8m704n4k.apps.googleusercontent.com',
    iosClientId:
        '598480896445-6nl0m8gtqh215rqe83jjd342a4pmufj2.apps.googleusercontent.com',
    iosBundleId: 'com.example.rentIt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBWyiYewza16GmRyLe_ODidxVAuIipgmcc',
    appId: '1:598480896445:ios:558787df386c5d997512d4',
    messagingSenderId: '598480896445',
    projectId: 'emo-app-3133d',
    storageBucket: 'emo-app-3133d.appspot.com',
    androidClientId:
        '598480896445-6kdqpracans69l3f39bfoemd8m704n4k.apps.googleusercontent.com',
    iosClientId:
        '598480896445-6nl0m8gtqh215rqe83jjd342a4pmufj2.apps.googleusercontent.com',
    iosBundleId: 'com.example.rentIt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBlzdzspQooTjfQujlcTFs2C1gqj4-yMZs',
    appId: '1:598480896445:web:f46a97ef26bcc00d7512d4',
    messagingSenderId: '598480896445',
    projectId: 'emo-app-3133d',
    authDomain: 'emo-app-3133d.firebaseapp.com',
    storageBucket: 'emo-app-3133d.appspot.com',
    measurementId: 'G-RZK33SD1ZV',
  );
}
