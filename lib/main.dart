// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
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
  const AuthWrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 24, 12, 27),
            body: Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 255, 255),
                strokeWidth: 5,
              ),
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return FutureBuilder<bool>(
            future: checkIfUserExists(snapshot.data!.email!),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 24, 12, 27),
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 255, 255),
                      strokeWidth: 5,
                    ),
                  ),
                );
              } else if (userSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${userSnapshot.error}'),
                  ),
                );
              } else if (userSnapshot.data == true) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }

  Future<bool> checkIfUserExists(String email) async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      return snapshot.exists;
    } catch (e) {
      print('Error checking user existence: $e');
      return false;
    }
  }
}
