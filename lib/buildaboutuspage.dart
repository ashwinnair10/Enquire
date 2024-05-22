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
                    'https://www.liveabout.com/thmb/MxxvP4jy81Tl3WeLrmWyT8SUXAg=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/FamilyGuy_GenericArt2011_Flat_v4-56a00b595f9b58eba4aea434.jpg'),
                buildaboutusbox(context, 'B21s',
                    'https://i.pinimg.com/originals/dd/b0/16/ddb0163166732ce36dc1833f6236f3bd.jpg'),
                buildaboutusbox(context, 'B22s',
                    'https://culturedvultures.com/wp-content/uploads/2022/07/Family-Guy.jpg'),
                buildaboutusbox(context, 'Alumni',
                    'https://img1.hotstarext.com/image/upload/f_auto,t_hcdl/sources/r1/cms/prod/3501/673501-h'),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: buildbottombar(context),
  );
}
