// ignore_for_file: prefer_const_constructors
import 'package:enquire/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Oswald'),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        return FirebaseOptions(
          apiKey: 'AIzaSyA849iBNdLBjOqhHtcVEMOvVX1qMhVQLfg',
          appId: '1:759084936586:android:681ace61b0923d2f5d6c73',
          messagingSenderId: '759084936586',
          projectId: 'enquire-fdc88',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA849iBNdLBjOqhHtcVEMOvVX1qMhVQLfg',
    appId: '1:759084936586:android:681ace61b0923d2f5d6c73',
    messagingSenderId: '759084936586',
    projectId: 'enquire-fdc88',
    databaseURL:
        'https://enquire-fdc88-default-rtdb.asia-southeast1.firebasedatabase.app/',
    storageBucket: 'gs://enquire-fdc88.appspot.com',
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
