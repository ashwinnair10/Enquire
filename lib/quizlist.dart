// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget buildquizlist(BuildContext context) {
  obtaindate(String str, int l) {
    var k = "";
    for (int i = l - 1; i >= 0 && str[i] != ' '; i--) {
      k = str[i] + k;
    }

    print(k);
    return k;
  }

  obtainname(String str, int l) {
    var k = "";
    for (int i = 0; i < l && str[i] != ' '; i++) {
      k = k + str[i];
    }
    print(k);
    return k;
  }

  print(FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.email)
      .collection('quizzes')
      .get());

  final Stream<QuerySnapshot> list = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.email)
      .collection('quizzes')
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
    stream: list,
    builder: (
      BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot,
    ) {
      if (snapshot.hasData == false) {
        print(snapshot);
        return Text(
          'NIL',
          style: TextStyle(
            color: Colors.white,
          ),
        );
      }
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

      return Container(
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        height: 350,
        padding: EdgeInsets.all(0),
        child: ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            print(data.docs[index]['quiz']);
            int l = data.docs[index]['quiz'].length;
            var date = obtaindate(data.docs[index]['quiz'], l);
            var quiz = obtainname(data.docs[index]['quiz'], l);
            var score = data.docs[index]['score'];
            var total = data.docs[index]['total'];
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 48, 28, 51),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.event_available_rounded,
                        color: Color.fromARGB(255, 253, 246, 255),
                        size: 40,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      if (score != -1)
                        {
                          Text(
                            '$score / $total',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Color.fromARGB(255, 253, 246, 255),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        } as Widget,
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
