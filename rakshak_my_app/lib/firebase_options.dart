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
    // apiKey: <use_your_api_key_or contact for api key>,
    appId: '1:100754056549:web:4f1be7b508b2625fa46d8c',
    messagingSenderId: '100754056549',
    projectId: 'rakshak-my-app',
    authDomain: 'rakshak-my-app.firebaseapp.com',
    storageBucket: 'rakshak-my-app.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    // apiKey: <use_your_api_key_or contact for api key>,
    appId: '1:100754056549:web:4f1be7b508b2625fa46d8c',
    messagingSenderId: '100754056549',
    projectId: 'rakshak-my-app',
    authDomain: 'rakshak-my-app.firebaseapp.com',
    storageBucket: 'rakshak-my-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    // apiKey: <use_your_api_key_or contact for api key>,
    appId: '1:100754056549:android:ec4cfb9fc77d7c52a46d8c',
    messagingSenderId: '100754056549',
    projectId: 'rakshak-my-app',
    storageBucket: 'rakshak-my-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    // apiKey: <use_your_api_key_or contact for api key>,
    appId: '1:100754056549:ios:564980a0d2405fc7a46d8c',
    messagingSenderId: '100754056549',
    projectId: 'rakshak-my-app',
    storageBucket: 'rakshak-my-app.appspot.com',
    iosBundleId: 'com.example.rakshakMyApp',
  );
}



// AIzaSyAm4rdmn8BjbJkGsPYrlHSCwTkib2YzVB4  AIzaSyBK_FrHOrDA_eHJp2i4aFlI5bFs_k48Gi8 AIzaSyASqHoP7xepeEhPWnOX4R8J-fiwL-uzZ8M
