// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget buildbottombar(BuildContext context) {
  return Container(
    color: Color.fromARGB(101, 0, 0, 0),
    width: MediaQuery.of(context).size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 5,
        ),
        Text(
          'Social Media',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Text(
                    'Instagram',
                    style: TextStyle(
                      color: Color.fromARGB(255, 253, 196, 169),
                    ),
                  ),
                  onTap: () => launchUrlString(
                      'https://www.instagram.com/enquire_nitc/'),
                ),
              ],
            ),
            InkWell(
              child: Text(
                'LinkedIn',
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 196, 169),
                ),
              ),
              onTap: () => launchUrlString(
                  'https://www.linkedin.com/company/enquireclubnitc/'),
            ),
            InkWell(
              child: Text(
                'Facebook',
                style: TextStyle(
                  color: Color.fromARGB(255, 253, 196, 169),
                ),
              ),
              onTap: () =>
                  launchUrlString('https://www.facebook.com/enquirequizclub'),
            ),
          ],
        ),
        Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'enquireclub@nitc.ac.in',
          style: TextStyle(
            color: Color.fromARGB(255, 253, 196, 169),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
