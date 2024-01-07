// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, use_super_parameters, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, unused_field, prefer_final_fields

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/quiz.dart';
import 'package:enquire/result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String title, id;
  final DateTime date;

  const QuizPage({
    Key? key,
    required this.title,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Timer _quizTimer;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<Map<String, dynamic>> _questions = [];
  var _questionIndex = 0;
  bool _quizCompleted = false;
  TextEditingController answerController = TextEditingController();
  late List<String?> _userAnswers;
  String _ongoingAnswer = '';

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _checkQuizCompletedStatus();
    _startQuizTimer();
  }

  Future<void> _checkQuizCompletedStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('event')
          .doc(widget.id)
          .collection('quiz_completed')
          .doc(user.displayName)
          .get();
      setState(() {
        _quizCompleted =
            snapshot.exists && snapshot.data()?['completed'] == true;
      });
    }
  }

  Future<void> _fetchQuestions() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('event')
        .doc(widget.id)
        .collection('questions')
        .get();
    setState(() {
      _questions = snapshot.docs.map((doc) => doc.data()).toList();
      print(_questions);
      _userAnswers = List.generate(_questions.length, (index) => null);
    });
  }

  void _answerQuestion(String answer) {
    setState(() {
      _ongoingAnswer = answer;
      print('ongoing: $_ongoingAnswer');
    });
  }

  void _calculateScoreAndNavigate() {
    _userAnswers[_questionIndex] = _ongoingAnswer;
    int _totalScore = 0;
    for (int i = 0; i < _userAnswers.length; i++) {
      if (_userAnswers[i]?.toLowerCase() ==
          _questions[i]['answer'].toString().toLowerCase()) {
        _totalScore++;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Result(
          widget.title,
          widget.date,
          _totalScore,
          FirebaseAuth.instance.currentUser as User,
          widget.id,
          _userAnswers,
        ),
      ),
    );
  }

  void _nextQuestion() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _userAnswers[_questionIndex] = _ongoingAnswer;
        print('user answer array ans$_questionIndex = $_ongoingAnswer');
        _questionIndex++;
        print('next q $_questionIndex');
        answerController.clear();
        _ongoingAnswer = _userAnswers[_questionIndex] ?? '';
      });
    } else {
      _calculateScoreAndNavigate();
    }
  }

  void _previousQuestion() {
    if (_questionIndex > 0) {
      setState(() {
        _userAnswers[_questionIndex] = _ongoingAnswer;
        print('user answer array ans$_questionIndex = $_ongoingAnswer');
        _questionIndex--;
        answerController.clear();
        _ongoingAnswer = _userAnswers[_questionIndex] ?? '';
      });
    }
  }

  int _remainingTimeInSeconds = 0;
  Future<void> _startQuizTimer() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('event').doc(widget.id).get();
    setState(() {
      _remainingTimeInSeconds = snapshot.data()?['time'];
    });
    _quizTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTimeInSeconds > 0) {
          _remainingTimeInSeconds--;
        } else {
          _quizTimer.cancel();

          _calculateScoreAndNavigate();
        }
      });
    });
  }

  @override
  void dispose() {
    _quizTimer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: _questions.isNotEmpty
              ? Quiz(
                  questions: _questions,
                  answerQuestion: _answerQuestion,
                  calculateScoreAndNavigate: _calculateScoreAndNavigate,
                  previousQuestion:
                      _questionIndex > 0 ? _previousQuestion : null,
                  nextQuestion: _questionIndex < _questions.length - 1
                      ? _nextQuestion
                      : null,
                  questionIndex: _questionIndex,
                  answerController: answerController,
                  isLastQuestion: _questionIndex == _questions.length - 1,
                  ongoingAnswer: _ongoingAnswer,
                  useranswers: _userAnswers,
                  remainingTimeInSeconds: _remainingTimeInSeconds,
                )
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
