// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, use_build_context_synchronously, avoid_function_literals_in_foreach_calls, avoid_print, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/home.dart';
import 'package:enquire/login_page.dart';
import 'package:enquire/quizlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late User _currentUser;
  String school = '';

  Future<void> schoolname() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.email)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          school = value.data()?['school'].toString() ?? '';
          print(school);
        });
      }
    });
  }

  int quiz = 0;

  Future<void> quiznumber() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.email)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          quiz = value.data()?['quiz'] ?? 0;
          print(quiz);
        });
      }
    });
  }

  var date = FirebaseAuth.instance.currentUser!.metadata.creationTime!;
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  var url = FirebaseAuth.instance.currentUser!.photoURL;
  @override
  void initState() {
    _currentUser = user as User;
    super.initState();
    schoolname();
    quiznumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Color.fromARGB(255, 253, 246, 255),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  setState(
                    () {
                      _isSigningOut = true;
                    },
                  );
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  if (mounted) {
                    setState(
                      () {
                        _isSigningOut = false;
                      },
                    );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  }
                  ;
                },
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 24, 12, 27),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Color.fromARGB(255, 24, 12, 27),
                      ),
                    )
                  ],
                ),
              ),
            ],
            offset: Offset(0, 50),
            color: Color.fromARGB(255, 253, 246, 255),
            elevation: 2,
          ),
        ],
        leading: IconButton(
          onPressed: () => {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false,
            ),
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 149, 100),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_currentUser.displayName}',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                          height: 0.9,
                          color: Color.fromARGB(255, 253, 246, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        '${_currentUser.email}',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          height: 0.9,
                          color: Color.fromARGB(255, 253, 246, 255),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _currentUser.emailVerified
                          ? Text(
                              'Email verified',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Email not verified',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 253, 246, 255),
                    backgroundImage:
                        NetworkImage(_currentUser.photoURL as String),
                    radius: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                school,
                maxLines: 2,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  height: 0.9,
                  color: Color.fromARGB(255, 253, 246, 255),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Date of joining: ${date.day}/${date.month}/${date.year}',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  color: Color.fromARGB(255, 253, 246, 255),
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 246, 255),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.emoji_events,
                      color: Color.fromARGB(255, 87, 5, 107),
                      size: 50,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Quizzes\nAttempted',
                      maxLines: 2,
                      style: TextStyle(
                        color: Color.fromARGB(255, 87, 5, 107),
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 87, 5, 107),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      width: (MediaQuery.of(context).size.width - 40) / 2 - 30,
                      child: Center(
                        child: Text(
                          '$quiz',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 253, 246, 255),
                            fontSize: 50,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: buildquizlist(context),
            ),
          ],
        ),
      ),
    );
  }
}
