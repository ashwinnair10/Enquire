import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

final Stream<QuerySnapshot> img =
    FirebaseFirestore.instance.collection('carouselimages').snapshots();

Widget buildShimmerImageSlider(BuildContext context) {
  return SizedBox(
    height: 200,
    width: MediaQuery.of(context).size.width - 30,
    child: ListView(
      children: [
        CarouselSlider(
          items: List.generate(
            5,
            (index) => Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[300],
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
      ],
    ),
  );
}

Widget buildimageslider(BuildContext context) {
  return StreamBuilder<QuerySnapshot>(
    stream: img,
    builder: (
      BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot,
    ) {
      if (snapshot.hasError) {
        return Center(
          child: Text('ERROR'),
        );
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return buildShimmerImageSlider(context);
      }
      final data = snapshot.requireData;
      return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width - 30,
        child: ListView(
          children: [
            CarouselSlider(
              items: data.docs.map((doc) {
                return Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(doc['url']),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
          ],
        ),
      );
    },
  );
}
