// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/person.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> currexec =
    FirebaseFirestore.instance.collection('currentexecutives').snapshots();

class CurrentExecutivePage extends StatefulWidget {
  const CurrentExecutivePage({super.key});

  @override
  State<CurrentExecutivePage> createState() => _CurrentExecutiveState();
}

class _CurrentExecutiveState extends State<CurrentExecutivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          'Current Executives',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: currexec,
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
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          final data = snapshot.requireData;
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: data.size,
              itemBuilder: (
                context,
                index,
              ) {
                return buildperson(
                  context,
                  data.docs[index]['name'],
                  data.docs[index]['url'],
                  data.docs[index]['des'],
                );
              });
        },
      ),
    );
  }
}
