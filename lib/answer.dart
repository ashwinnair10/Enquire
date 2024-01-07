// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  final Function selectHandler;
  final String answerText;
  final bool isSelected;

  Answer(this.selectHandler, this.answerText, this.isSelected, {super.key});

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          widget.selectHandler();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            widget.isSelected
                ? Color.fromARGB(255, 43, 66, 82) // Selected color
                : Color.fromARGB(255, 202, 240, 248), // Default color
          ),
        ),
        child: Text(
          widget.answerText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: widget.isSelected
                ? Colors.white // Text color when selected
                : Color.fromARGB(255, 19, 31, 41), // Default text color
          ),
        ),
      ),
    );
  }
}
