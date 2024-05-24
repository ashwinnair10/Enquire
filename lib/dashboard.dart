// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/home.dart';
import 'package:enquire/login_page.dart';
import 'package:enquire/quizlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late User _currentUser;
  String school = '';
  int quiz = 0;
  bool isLoading = true;

  Future<void> fetchData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.email)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          school = value.data()?['school'].toString() ?? '';
          quiz = value.data()?['quiz'] ?? 0;
          isLoading = false;
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
    fetchData();
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
                  setState(() {
                    _isSigningOut = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  if (mounted) {
                    setState(() {
                      _isSigningOut = false;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  }
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
            iconColor: Color.fromARGB(255, 253, 246, 255),
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
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 55, 55, 55),
                            highlightColor: Color.fromARGB(255, 100, 100, 100),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              width: 150,
                              height: 25,
                            ),
                          )
                        : Text(
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
                    isLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 55, 55, 55),
                            highlightColor: Color.fromARGB(255, 100, 100, 100),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 200,
                              height: 15,
                            ),
                          )
                        : Text(
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
            SizedBox(
              height: 10,
            ),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 55, 55, 55),
                    highlightColor: Color.fromARGB(255, 100, 100, 100),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                    ),
                  )
                : Text(
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
            SizedBox(
              height: 20,
            ),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 55, 55, 55),
                    highlightColor: Color.fromARGB(255, 100, 100, 100),
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 20,
                    ),
                  )
                : Text(
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
            SizedBox(
              height: 30,
            ),
            isLoading
                ? Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 55, 55, 55),
                    highlightColor: Color.fromARGB(255, 100, 100, 100),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 100,
                    ),
                  )
                : Container(
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
                          width:
                              (MediaQuery.of(context).size.width - 40) / 2 - 30,
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
            SizedBox(
              height: 30,
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
