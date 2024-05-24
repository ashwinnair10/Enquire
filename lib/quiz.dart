// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Function calculateScoreAndNavigate;
  final void Function()? previousQuestion;
  final void Function()? nextQuestion;
  final TextEditingController answerController;
  final bool isLastQuestion;
  final String ongoingAnswer;
  final List<String?> useranswers;
  final int remainingTimeInSeconds;

  const Quiz({
    super.key,
    required this.questions,
    required this.answerQuestion,
    required this.calculateScoreAndNavigate,
    required this.previousQuestion,
    required this.nextQuestion,
    required this.questionIndex,
    required this.answerController,
    required this.isLastQuestion,
    required this.ongoingAnswer,
    required this.useranswers,
    required this.remainingTimeInSeconds,
  });

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    int answeredQuestions = widget.useranswers
        .where((answer) => (answer != '') && (answer != null))
        .length;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10, 40, 10, 40),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.previousQuestion != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 149, 100),
                      ),
                      onPressed: widget.previousQuestion as void Function(),
                      child: Icon(
                        Icons.arrow_left,
                        color: Color.fromARGB(255, 72, 0, 87),
                      ),
                    ),
                  Spacer(),
                  if (!widget.isLastQuestion)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 149, 100),
                      ),
                      onPressed: widget.nextQuestion as void Function(),
                      child: Icon(
                        Icons.arrow_right,
                        color: Color.fromARGB(255, 72, 0, 87),
                      ),
                    ),
                ],
              ),
              Container(
                width: 80,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 72, 0, 87),
                  border: Border.all(
                    color: const Color.fromARGB(255, 80, 13, 92),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${widget.remainingTimeInSeconds ~/ 60}:${widget.remainingTimeInSeconds % 60}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 246, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Attempted : $answeredQuestions / ${widget.questions.length}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 253, 246, 255),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 36, 36, 36),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.questions[widget.questionIndex]['question']
                              .toString(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Color.fromARGB(255, 253, 246, 255),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromARGB(255, 72, 0, 87),
                ),
                child: Text(
                  'Q${widget.questionIndex + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 253, 246, 255),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            style: TextStyle(
              color: Color.fromARGB(255, 253, 246, 255),
            ),
            controller: widget.answerController..text = widget.ongoingAnswer,
            onChanged: (answer) {
              widget.answerQuestion(widget.answerController.text);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Your Answer",
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 72, 0, 87),
                  width: 2,
                ),
              ),
              labelText: 'Your Answer',
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 72, 0, 87),
                  width: 2,
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
          SizedBox(height: 25),
          widget.isLastQuestion
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    backgroundColor: Color.fromARGB(255, 72, 0, 87),
                  ),
                  onPressed: () {
                    widget.calculateScoreAndNavigate();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Color.fromARGB(255, 253, 246, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 30,
          ),
          LinearProgressIndicator(
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
            value: (widget.questionIndex + 1) / widget.questions.length,
            backgroundColor: Color.fromARGB(255, 253, 246, 255),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromARGB(255, 255, 149, 100),
            ),
          ),
        ],
      ),
    );
  }
}
