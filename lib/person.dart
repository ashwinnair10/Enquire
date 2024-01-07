// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildperson(BuildContext context, String name, img, des) {
  return SizedBox(
    height: MediaQuery.of(context).size.width - 30,
    width: MediaQuery.of(context).size.width - 30,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(img),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          name,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color.fromARGB(255, 253, 246, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          des,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 149, 100),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
