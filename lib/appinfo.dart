// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:enquire/home.dart';
import 'package:flutter/material.dart';

class AppInfoPage extends StatefulWidget {
  const AppInfoPage({super.key});
  @override
  State<AppInfoPage> createState() => _AppInfoPageState();
}

class _AppInfoPageState extends State<AppInfoPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 24, 12, 27),
          title: Text(
            'Info',
            style: TextStyle(
                color: Color.fromARGB(255, 253, 246, 255),
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            onPressed: () => {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
                (route) => false,
              ),
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 255, 149, 100),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 24, 12, 27),
      ),
    );
  }
}
