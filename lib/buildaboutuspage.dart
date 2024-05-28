// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:enquire/aboutusbox.dart';
import 'package:enquire/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildaboutuspage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 24, 12, 27),
    body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              childAspectRatio: 0.75,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                buildaboutusbox(context, 'Current Executives',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIPirQ2pRmwbPE8JGguvnVos7ulPdY9MgD_HR0ioZzMg&s'),
                buildaboutusbox(context, 'B21s',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIPirQ2pRmwbPE8JGguvnVos7ulPdY9MgD_HR0ioZzMg&s'),
                buildaboutusbox(context, 'B22s',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIPirQ2pRmwbPE8JGguvnVos7ulPdY9MgD_HR0ioZzMg&s'),
                buildaboutusbox(context, 'Alumni',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIPirQ2pRmwbPE8JGguvnVos7ulPdY9MgD_HR0ioZzMg&s'),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: buildbottombar(context),
  );
}
