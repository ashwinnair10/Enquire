// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/testquizpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

int l = 0, t = 0;

class InstructionPage extends StatefulWidget {
  final String title, id, instruct;
  final DateTime date;

  const InstructionPage({
    required this.title,
    required this.date,
    required this.id,
    required this.instruct,
    super.key,
  });

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  Future<void> test() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('event')
        .doc(widget.id)
        .collection('questions')
        .get();
    l = snapshot.docs.map((doc) => doc.data()).toList().length;
    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('event')
        .doc(widget.id)
        .get();
    t = snap.data()?['time'];
  }

  Future<void> attempt() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('event')
        .doc(widget.id)
        .collection('quiz_completed')
        .doc(user?.displayName)
        .set({
      'name': user?.displayName,
      'completed': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    test();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 149, 100),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              'Before you start the quiz, please review the following instructions carefully: ',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 253, 246, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.all(
                        20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Technical Requirements:  Ensure a stable internet connection.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Navigation:  Utilize the "Next" and "Back" buttons for navigation. Review your answers before moving to the next question.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Submission:  Ensure all questions are answered before submitting. Once submitted, changes cannot be made.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Questions : $l',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Time : ${t / 60} mins',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 253, 246, 255),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            widget.instruct,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  padding: EdgeInsets.all(
                    10,
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 111, 62),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Instructions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 253, 246, 255),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Best of luck with the quiz!',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 253, 246, 255),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color.fromARGB(255, 218, 111, 62),
              ),
              onPressed: () {
                attempt();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(
                      title: widget.title,
                      date: widget.date,
                      id: widget.id,
                    ),
                  ),
                );
              },
              child: Text(
                'Proceed to Quiz',
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 246, 255),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
