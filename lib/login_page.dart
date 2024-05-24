// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './fire_auth.dart';
import './register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isProcessing = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 253, 246, 255),
          title: Text(
            "Login Failed",
            style: TextStyle(
              color: Color.fromARGB(255, 24, 12, 27),
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Color.fromARGB(255, 24, 12, 27),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _initializeFirebase(BuildContext context) async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      bool userExists = await checkIfUserExists(user.email!);

      if (userExists) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      } else {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => RegisterPage(user: user),
            ),
          );
        }
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        body: FutureBuilder(
          future: _initializeFirebase(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 253, 246, 255),
                  strokeWidth: 5,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(30, 150, 30, 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 253, 246, 255),
                      backgroundImage: AssetImage('assets/ic_launcher.jpg'),
                      radius: 70,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'EnQuire',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 149, 100),
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(height: 30),
                    _isProcessing
                        ? CircularProgressIndicator(
                            color: Color.fromARGB(255, 253, 246, 255),
                            strokeWidth: 5,
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _isProcessing = true;
                                });

                                User? user = await FireAuth.signInWithGoogle();

                                if (mounted) {
                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  if (user != null && user.email != null) {
                                    bool userExists =
                                        await checkIfUserExists(user.email!);

                                    if (userExists) {
                                      if (mounted) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      }
                                    } else {
                                      if (mounted) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage(user: user),
                                          ),
                                        );
                                      }
                                    }
                                  } else {
                                    print('User or user email is null');
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content:
                                              Text('Google Sign-In Failed'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image.network(
                                        'https://archive.org/download/github.com-google-flutter-desktop-embedding_-_2019-01-02_05-44-41/cover.jpg'),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Sign In with Google',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Color.fromARGB(255, 24, 12, 27),
                    ),
                    //SizedBox(height: 200),
                    //Text('Project by Ashwin A Nair'),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
