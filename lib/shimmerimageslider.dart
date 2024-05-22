import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
              //margin: EdgeInsets.all(6.0),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20.0),
              //   color: Colors.grey[300],
              // ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
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
