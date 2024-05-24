import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquire/archivebox.dart';
import 'package:enquire/shimmerarchivebox.dart';
import 'package:flutter/material.dart';

final Stream<QuerySnapshot> archive =
    FirebaseFirestore.instance.collection('archive').snapshots();

Widget buildarchivepage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 24, 12, 27),
    body: FutureBuilder(
      future: Future.delayed(Duration(seconds: 2)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            padding: EdgeInsets.all(10),
            itemCount: 4,
            itemBuilder: (context, index) {
              return buildShimmerArchiveBox();
            },
          );
        } else {
          return StreamBuilder<QuerySnapshot>(
            stream: archive,
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20, childAspectRatio: 0.75,
                    // mainAxisExtent: MediaQuery.of(context).size.width / 2 + 20,
                  ),
                  padding: EdgeInsets.all(10),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return buildShimmerArchiveBox();
                  },
                );
              }

              final data = snapshot.requireData;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20, childAspectRatio: 0.75,
                  //mainAxisExtent: MediaQuery.of(context).size.width / 2 + 20,
                ),
                padding: EdgeInsets.all(10),
                itemCount: data.size,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return buildarchivebox(
                    context,
                    data.docs[index],
                  );
                },
              );
            },
          );
        }
      },
    ),
  );
}
