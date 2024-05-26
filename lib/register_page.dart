// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './home.dart';
import './validator.dart';

class RegisterPage extends StatefulWidget {
  final User user;

  const RegisterPage({super.key, required this.user});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _schoolTextController = TextEditingController();
  final _focusSchool = FocusNode();
  bool _isProcessing = false;
  bool _isSigningOut = false;

  Future<void> saveUser(String school) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(widget.user.email).set({
      'name': widget.user.displayName,
      'email': widget.user.email,
      'school': school,
      'quiz': 0,
    });
    print('User saved: ${widget.user.email}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusSchool.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 12, 27),
          title: Text(
            'Register',
            style: TextStyle(
              color: Color.fromARGB(255, 253, 246, 255),
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            onPressed: () async {
              setState(() {
                _isSigningOut = true;
              });

              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();

              setState(() {
                _isSigningOut = false;
              });

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 255, 149, 100),
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        controller: _schoolTextController,
                        focusNode: _focusSchool,
                        validator: (value) => Validator.validateSchool(
                          str: value,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "School",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 253, 246, 255),
                          ),
                          labelText: 'School',
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
                      SizedBox(height: 32.0),
                      _isProcessing
                          ? CircularProgressIndicator(
                              color: Color.fromARGB(255, 253, 246, 255),
                              strokeWidth: 5,
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 255, 149, 100),
                              ),
                              onPressed: () async {
                                _focusSchool.unfocus();

                                if (_registerFormKey.currentState!.validate()) {
                                  setState(() {
                                    _isProcessing = true;
                                  });

                                  await saveUser(
                                    _schoolTextController.text,
                                  );

                                  setState(() {
                                    _isProcessing = false;
                                  });

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
