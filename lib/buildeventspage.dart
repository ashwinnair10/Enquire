// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/eventbox.dart';
import 'package:enquire/shimmereventbox.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> event =
    FirebaseFirestore.instance.collection('event').snapshots();

Widget buildeventspage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 24, 12, 27),
    body: StreamBuilder<QuerySnapshot>(
      stream: event,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text('ERROR'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ShimmerEventBox(),
                ],
              );
            },
          );
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                buildeventbox(
                  context,
                  data.docs[index].id,
                  data.docs[index]['img'],
                  data.docs[index]['title'],
                  data.docs[index]['details'],
                  data.docs[index]['instruct'],
                  (data.docs[index]['date'] as Timestamp).toDate(),
                  data.docs[index]['quiz'],
                  data.docs[index]['time'],
                ),
              ],
            );
          },
        );
      },
    ),
  );
}
