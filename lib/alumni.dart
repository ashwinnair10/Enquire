// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/person.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> alumni =
    FirebaseFirestore.instance.collection('alumni').snapshots();

/*String img =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUaurAR2wvZkBqCWGVUoZW8Fr2pR82t1g_pw&usqp=CAU',
    name = 'name',
    des = 'designation';*/
class AlumniPage extends StatefulWidget {
  const AlumniPage({super.key});

  @override
  State<AlumniPage> createState() => _AlumniState();
}

class _AlumniState extends State<AlumniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
        title: Text(
          'Alumni',
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
        stream: alumni,
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
