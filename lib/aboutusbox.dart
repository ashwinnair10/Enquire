// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './currentexec.dart';
import './b21.dart';
import './b22.dart';
import './alumni.dart';

Widget buildaboutusbox(BuildContext context, String title, url) {
  sendto() {
    if (title == 'Current Executives') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CurrentExecutivePage(),
        ),
      );
    }
    if (title == 'B21s') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => B21Page(),
        ),
      );
    }
    if (title == 'B22s') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => B22Page(),
        ),
      );
    }
    if (title == 'Alumni') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlumniPage(),
        ),
      );
    }
  }

  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(255, 253, 246, 255),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image(
              image: NetworkImage(url),
              // height: 170,
              // // width: 170,
              fit: BoxFit.cover,
            ),
          ),
        ),
        TextButton(
          onPressed: () => {
            sendto(),
          },
          child: Text(
            title,
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color.fromARGB(255, 87, 5, 107),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.left,
          ),
        )
      ],
    ),
  );
}
