// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/person.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> b21 =
    FirebaseFirestore.instance.collection('b21s').snapshots();

class B21Page extends StatefulWidget {
  const B21Page({super.key});
  @override
  State<B21Page> createState() => _B21State();
}

class _B21State extends State<B21Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          'B21s',
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
        stream: b21,
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
