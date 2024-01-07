// ignore_for_file: prefer_const_constructors

import 'package:enquire/archivepage.dart';
import 'package:flutter/material.dart';

Widget buildarchivebox(BuildContext context, String title, url, q1, q2, q3, q4,
    q5, a1, a2, a3, a4, a5) {
  return Container(
    height: 200,
    width: 170,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(255, 253, 246, 255),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 5,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage(url),
            height: 165,
            width: 165,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArchivePage(
                  title: title,
                  q1: q1,
                  q2: q2,
                  q3: q3,
                  q4: q4,
                  q5: q5,
                  a1: a1,
                  a2: a2,
                  a3: a3,
                  a4: a4,
                  a5: a5,
                ),
              ),
            ),
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
