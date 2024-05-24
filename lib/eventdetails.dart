// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:enquire/instructionpage.dart';
import 'package:enquire/shimmereventdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final String id, img, title, details, instruct;
  final DateTime date;
  final bool quiz;
  final int time;

  const EventDetailsPage({
    super.key,
    required this.id,
    required this.img,
    required this.title,
    required this.details,
    required this.date,
    required this.quiz,
    required this.instruct,
    required this.time,
  });

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  bool? hasAttemptedQuiz;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkQuizCompletedStatus();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> _checkQuizCompletedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('event')
          .doc(widget.id)
          .collection('quiz_completed')
          .doc(user.email)
          .get();
      if (mounted) {
        setState(() {
          hasAttemptedQuiz =
              (snapshot.exists && snapshot.data()?['completed'] == true);
        });
      }
    } else {
      if (mounted) {
        setState(() {
          hasAttemptedQuiz = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 149, 100),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: isLoading ? ShimmerEventDetails() : buildEventDetails(context),
    );
  }

  Widget buildEventDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 253, 246, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width - 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Opacity(
                        opacity: 1,
                        child: Image(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.img),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(117, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 20,
                          ),
                        ],
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 40,
                      ),
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
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Date : ${widget.date.day} / ${widget.date.month} / ${widget.date.year}',
                      style: TextStyle(
                        color: Color.fromARGB(255, 72, 0, 87),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasAttemptedQuiz == null)
                CircularProgressIndicator(
                  color: Color.fromARGB(255, 72, 0, 87),
                )
              else if (widget.quiz &&
                  hasAttemptedQuiz != true &&
                  widget.date.day == DateTime.now().day &&
                  widget.date.month == DateTime.now().month &&
                  widget.date.year == DateTime.now().year &&
                  widget.date.hour <= DateTime.now().hour)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 72, 0, 87),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InstructionPage(
                          title: widget.title,
                          date: widget.date,
                          id: widget.id,
                          instruct: widget.instruct,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Take Quiz',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                )
              else
                SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
