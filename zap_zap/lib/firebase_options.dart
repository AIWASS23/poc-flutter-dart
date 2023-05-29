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
      // case TargetPlatform.windows:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for windows - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      // case TargetPlatform.linux:
      //   throw UnsupportedError(
      //     'DefaultFirebaseOptions have not been configured for linux - '
      //     'you can reconfigure this by running the FlutterFire CLI again.',
      //   );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCOEO_kOsiH15igWkQ3fQDcHXMEMbcgkqE',
    appId: '1:1003029818316:web:654abc519d194608a4cb69',
    messagingSenderId: '229535490391',
    projectId: 'zapzap-e2f72',
    authDomain: 'zapzap-e2f72.firebaseapp.com',
    storageBucket: 'zapzap-e2f72.appspot.com',
    measurementId: 'G-7QXZ6XER47',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBm2PlimA4gVh6CFY-Yuhla7dbMsIMmYDQ',
    appId: '1:229535490391:android:7f84e61dba719925731e12',
    messagingSenderId: '229535490391',
    projectId: 'zapzap-e2f72',
    storageBucket: 'zapzap-e2f72.appspot.com', 
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaSAO9VkXcu8HD1IMntrCt0-saShZoz0Q',
    appId: '1:229535490391:ios:17807e9fc4306901731e12',
    messagingSenderId: '229535490391',
    projectId: 'zapzap-e2f72',
    storageBucket: 'zapzap-e2f72.appspot.com',
    iosBundleId: 'com.example.zap-zap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaSAO9VkXcu8HD1IMntrCt0-saShZoz0Q',
    appId: '1:229535490391:ios:17807e9fc4306901731e12',
    messagingSenderId: '229535490391',
    projectId: 'zapzap-e2f72',
    storageBucket: 'zapzap-e2f72.appspot.com',
    iosBundleId: 'com.example.zap-zap',
  );
}