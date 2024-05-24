// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:enquire/imageslider.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

String intro =
    'NIT Calicut\'s Quiz Club, where curiosity fuels competition! Rooted in intellectual engagement, camaraderie, and a love for quizzing, we\'re a dynamic community hosting diverse events. Join us, whether you\'re a seasoned quizzer or a newcomer ready to explore the world of trivia. Let the quest for knowledge begin!';

Widget buildhomepage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 24, 12, 27),
    body: SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'to',
                      style: TextStyle(
                        fontSize: 50,
                        height: 0.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Enquire,',
                          textStyle: TextStyle(
                            //fontFamily: 'Oswald',

                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 149, 100),
                          ),
                          speed: Duration(
                            milliseconds: 200,
                          ),
                        ),
                      ],
                      pause: Duration(
                        milliseconds: 5000,
                      ),
                      repeatForever: true,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      intro,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromARGB(255, 253, 246, 255),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildimageslider(context),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    ),
    //bottomNavigationBar: buildbottombar(context),
  );
}
