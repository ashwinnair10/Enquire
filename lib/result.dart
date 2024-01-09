// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int call = 0;

class Result extends StatefulWidget {
  final String title;
  final DateTime date;
  final int totalScore;
  final User user;
  final String id;
  final List<String?> useranswers;
  Result(
    this.title,
    this.date,
    this.totalScore,
    this.user,
    this.id,
    this.useranswers,
  );
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<void> _handleCompletion() async {
    print(call);
    if (call == 0) {
      print('check 1');
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.email)
          .get();
      print('check 2');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .set({
        'name': user?.displayName,
        'email': user?.email,
        'school': snapshot.data()?['school'],
        'quiz': (snapshot.data()?['quiz'] + 1)
      });

      print('check3');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .collection('quizzes')
          .doc(
              '${widget.title} ${widget.date.day}-${widget.date.month}-${widget.date.year}')
          .set({
        'quiz':
            '${widget.title} ${widget.date.day}-${widget.date.month}-${widget.date.year}',
        'score': -1,
        'total': widget.useranswers.length,
      });
      print('check 4');
      await FirebaseFirestore.instance
          .collection('event')
          .doc(widget.id)
          .collection('quiz_completed')
          .doc(user?.displayName)
          .set({
        'name': user?.displayName,
        'completed': true,
        'score': widget.totalScore,
        'useranswers': widget.useranswers,
      });
      print('check 5');
      call = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    _handleCompletion();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 75,
              ),
              Text(
                'Quiz Results',
                style: TextStyle(
                  fontSize: 40,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 50,
                    ),
                  ],
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 253, 246, 255),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Icon(
                Icons.emoji_events,
                color: Color.fromARGB(255, 255, 149, 100),
                size: 120,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Your score is currently being reviewed by our team',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 253, 246, 255),
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Scores will be visible in the dashboard soon! Results* will be published on our social media handles',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 253, 246, 255),
                  fontWeight: FontWeight.w300,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                '*( Winners will be notified via email )',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 253, 246, 255),
                  fontWeight: FontWeight.w300,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 50,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color.fromARGB(255, 255, 149, 100),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                },
                child: Text(
                  'Go to Dashboard',
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 246, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
