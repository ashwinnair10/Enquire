// ignore_for_file: prefer_const_constructors

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/eventdetails.dart';
import 'package:flutter/material.dart';

Widget buildeventbox(BuildContext context, String id, img, title, details,
    instruct, DateTime date, bool quiz, int time) {
  return ElevatedButton(
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsPage(
            id: id,
            img: img,
            title: title,
            details: details,
            instruct: instruct,
            date: date,
            quiz: quiz,
            time: time,
          ),
        ),
      ),
    },
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(0),
    ),
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 246, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 160,
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        children: [
          // SizedBox(
          //   width: 5,
          // ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              image: NetworkImage(
                img,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color.fromARGB(255, 87, 5, 107),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  details,
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 28, 28, 28),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${date.day} / ${date.month} / ${date.year}',
                  style: TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 87, 5, 107),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
