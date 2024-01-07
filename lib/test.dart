// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final String id, img, title, details;
  final DateTime date;
  final bool quiz;

  const EventDetailsPage({
    super.key,
    required this.id,
    required this.img,
    required this.title,
    required this.details,
    required this.date,
    required this.quiz,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool? hasAttemptedQuiz; // Nullable to represent loading state

  @override
  void initState() {
    super.initState();
    _checkQuizCompletionStatus();
  }

  Future<void> _checkQuizCompletionStatus() async {
    // Check if the user is authenticated
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // If authenticated, check the user's completion status in Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('quiz_completion')
          .doc(user.uid)
          .get();

      setState(() {
        hasAttemptedQuiz =
            snapshot.exists && snapshot.data()?['completed'] == true;
      });
    } else {
      // If not authenticated, set hasAttemptedQuiz to null (loading state)
      setState(() {
        hasAttemptedQuiz = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... existing code ...
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 253, 228, 195),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ... existing code ...
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width - 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      4,
                    ),
                    child: Opacity(
                      opacity: 0.7,
                      child: Image(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.img,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        shadows: const [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 50,
                          ),
                        ],
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 40),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Text(
                      widget.details,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 238, 214),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date : ${widget.date.day} / ${widget.date.month} / ${widget.date.year}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
            if (hasAttemptedQuiz == null)
              CircularProgressIndicator()
            else if (widget.quiz && hasAttemptedQuiz != true)
              ElevatedButton(
                onPressed: () {
                  _navigateToQuizPage();
                },
                child: Text('Take Quiz'),
              )
            else
              SizedBox(),

            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToQuizPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          title: widget.title,
          id: widget.id,
          onQuizComplete: _handleQuizComplete,
        ),
      ),
    );
  }

  Future<void> _handleQuizComplete() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('quiz_completion')
          .doc(user.uid)
          .set({'completed': true});

      // Update the local state
      setState(() {
        hasAttemptedQuiz = true;
      });
    }
  }
}

class QuizPage extends StatelessWidget {
  final String title;
  final String id;
  final VoidCallback onQuizComplete;

  const QuizPage({
    super.key,
    required this.title,
    required this.id,
    required this.onQuizComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Your quiz page implementation
    // Make sure to call onQuizComplete() when the quiz is completed
    return Container();
  }
}
