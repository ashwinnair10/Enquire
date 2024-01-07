// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildqa(BuildContext context, String question, answer) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 255, 149, 100),
        ),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 246, 255),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Q: $question',
                style: TextStyle(
                  color: Color.fromARGB(255, 87, 5, 107),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Answer: $answer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
