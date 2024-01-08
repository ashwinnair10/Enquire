// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './register_page.dart';
import './fire_auth.dart';
import './validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  bool _isProcessing = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 202, 240, 248),
          title: Text(
            "Login Failed",
            style: TextStyle(
              color: Color.fromARGB(255, 28, 28, 28),
            ),
          ),
          content: Text(
            "Invalid email or password.",
            style: TextStyle(
              color: Color.fromARGB(255, 28, 28, 28),
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

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          body: FutureBuilder(
            future: _initializeFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 253, 246, 255),
                        backgroundImage: AssetImage('assets/ic_launcher.jpg'),
                        radius: 70,
                      ),
                      /*SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enquire',
                        style: TextStyle(
                          color: Color.fromARGB(255, 253, 246, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),*/
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              controller: _emailTextController,
                              focusNode: _focusEmail,
                              validator: (value) =>
                                  Validator.validateEmail(email: value),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 253, 246, 255),
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              controller: _passwordTextController,
                              focusNode: _focusPassword,
                              obscureText: true,
                              validator: (value) =>
                                  Validator.validatePassword(password: value),
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 253, 246, 255),
                                  ),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 253, 246, 255),
                                    width: 1,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            _isProcessing
                                ? CircularProgressIndicator(
                                    color: Color.fromARGB(255, 253, 246, 255),
                                    strokeWidth: 5,
                                  )
                                : Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 246, 255),
                                        ),
                                        onPressed: () async {
                                          _focusEmail.unfocus();
                                          _focusPassword.unfocus();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isProcessing = true;
                                            });
                                            User? user = await FireAuth
                                                .signInUsingEmailPassword(
                                              email: _emailTextController.text,
                                              password:
                                                  _passwordTextController.text,
                                            );
                                            setState(() {
                                              _isProcessing = false;
                                            });

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(),
                                                ),
                                              );
                                            } else {
                                              _showErrorDialog(
                                                  'Invalid credentials');
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Sign In',
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 28, 28, 28),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'New User?',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 253, 246, 255),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Register',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 253, 246, 255),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 253, 246, 255),
                  strokeWidth: 5,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(LoginPage());
}
