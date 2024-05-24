// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/archiveqa.dart';
import 'package:enquire/shimmerarchivebox.dart';
import 'package:enquire/shimmerarchiveqa.dart';
import 'package:flutter/material.dart';

class ArchivePage extends StatefulWidget {
  final String title;
  var questions;
  ArchivePage({super.key, required this.title, required this.questions});
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
      body: StreamBuilder<QuerySnapshot>(
        stream: widget.questions,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasData == false) {
            return Container(
              //width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return buildshimmerqa(context, "Loading", "Loading", "");
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return Container(
              //width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return buildshimmerqa(context, "Loading", "Loading", "");
                },
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              //width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return buildshimmerqa(context, "Loading", "Loading", "");
                },
              ),
            );
          }

          final data = snapshot.requireData;

          return Container(
            //width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return buildqa(context, data.docs[index]['question'],
                    data.docs[index]['answer'], data.docs[index]['img']);
              },
            ),
          );
        },
      ),
    );
  }
}
