// ignore_for_file: prefer_const_constructors
import 'package:enquire/login_page.dart';
import 'package:enquire/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 253, 246, 255),
                strokeWidth: 5,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
