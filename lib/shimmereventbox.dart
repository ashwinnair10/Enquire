import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEventBox extends StatelessWidget {
  const ShimmerEventBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 253, 246, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      height: 160,
      width: MediaQuery.of(context).size.width - 20,
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade200,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.white,
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
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width - 250,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 250,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade200,
                  child: Container(
                    height: 20,
                    width: 100,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
