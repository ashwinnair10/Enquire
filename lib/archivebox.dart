// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/archivepage.dart';
import 'package:flutter/material.dart';

Widget buildarchivebox(
    BuildContext context, QueryDocumentSnapshot<Object?> data) {
  CollectionReference<Object?> questions =
      data.reference.collection('questions');
  return Container(
    // height: 200,
    // width: 170,
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
              image: NetworkImage(data['url']),
              // height: 165,
              // width: 165,
              fit: BoxFit.cover,
            ),
          ),
        ),
        TextButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArchivePage(
                  title: data['title'],
                  questions: questions.snapshots(),
                ),
              ),
            ),
          },
          child: Text(
            data['title'],
            style: TextStyle(
              height: 1,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Color.fromARGB(255, 87, 5, 107),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}
