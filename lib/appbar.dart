// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

PreferredSizeWidget buildTopBar(BuildContext context) {
  return AppBar(
    elevation: 1.0,
    backgroundColor: Colors.grey.shade800,
    title: Text(
      'EnQuire',
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      IconButton(
        color: Colors.white,
        onPressed: () => {},
        iconSize: 27,
        icon: Icon(
          Icons.account_circle,
        ),
      ),
    ],
  );
}
