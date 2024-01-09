// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildqa(BuildContext context, String question, answer, img) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 255, 149, 100),
        ),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 20,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 246, 255),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Q: $question',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 87, 5, 107),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      fontSize: 18,
                    ),
                  ),
                  if (img != '')
                    SizedBox(
                      height: 20,
                    ),
                  if (img != '')
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 200,
                      child: Image.network(
                        img,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                ],
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
