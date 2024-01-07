// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:enquire/archiveqa.dart';
import 'package:flutter/material.dart';

class ArchivePage extends StatefulWidget {
  final String title, q1, q2, q3, q4, q5, a1, a2, a3, a4, a5;
  const ArchivePage(
      {super.key,
      required this.title,
      required this.q1,
      required this.q2,
      required this.q3,
      required this.q4,
      required this.q5,
      required this.a1,
      required this.a2,
      required this.a3,
      required this.a4,
      required this.a5});
  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          widget.title,
          style: TextStyle(
              color: Color.fromARGB(255, 253, 246, 255),
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 255, 149, 100),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 24, 12, 27),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildqa(context, widget.q1, widget.a1),
            buildqa(context, widget.q2, widget.a2),
            buildqa(context, widget.q3, widget.a3),
            buildqa(context, widget.q4, widget.a4),
            buildqa(context, widget.q5, widget.a5),
            /* SizedBox(
              height: 20,
            ),
            Text(
              'Q1: ${widget.q1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'Answer: ${widget.a1}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 238, 214),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Q2: ${widget.q2}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'Answer: ${widget.a2}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 238, 214),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Q3: ${widget.q3}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'Answer: ${widget.a3}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 238, 214),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Q4: ${widget.q4}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'Answer: ${widget.a4}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 238, 214),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Q5: ${widget.q5}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'Answer: ${widget.a5}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 238, 214),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
          ],
        ),
      ),
    );
  }
}
