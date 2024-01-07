// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:enquire/aboutusbox.dart';
//import 'package:enquire/alumni.dart';
//import 'package:enquire/b21.dart';
//import 'package:enquire/b22.dart';
import 'package:enquire/bottombar.dart';
//import 'package:enquire/currentexec.dart';
import 'package:flutter/material.dart';

Widget buildaboutuspage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 24, 12, 27),
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildaboutusbox(context, 'Current Executives',
                  'https://www.liveabout.com/thmb/MxxvP4jy81Tl3WeLrmWyT8SUXAg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/FamilyGuy_GenericArt2011_Flat_v4-56a00b595f9b58eba4aea434.jpg'),
              buildaboutusbox(context, 'B21s',
                  'https://i.pinimg.com/originals/dd/b0/16/ddb0163166732ce36dc1833f6236f3bd.jpg'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildaboutusbox(context, 'B22s',
                  'https://culturedvultures.com/wp-content/uploads/2022/07/Family-Guy.jpg'),
              buildaboutusbox(context, 'Alumni',
                  'https://img1.hotstarext.com/image/upload/f_auto,t_hcdl/sources/r1/cms/prod/3501/673501-h'),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          buildbottombar(context),
        ],
      ),
    ),
  );
}
/*SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Current Executives',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 202, 240, 248),
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrentExecutivePage(),
                      ),
                    ),
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 43, 66, 82),
                        radius: 75,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'B21s',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 202, 240, 248),
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => B21Page(),
                      ),
                    ),
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 43, 66, 82),
                        radius: 75,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'B22s',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 202, 240, 248),
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => B22Page(),
                      ),
                    ),
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 43, 66, 82),
                        radius: 75,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Alumni',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 202, 240, 248),
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlumniPage(),
                      ),
                    ),
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 43, 66, 82),
                        radius: 75,
                      ),
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildbottombar(context),
            ],
          ),
        ],
      ),
    ), */