import 'package:flutter/material.dart';

Widget flickerImage(
    {required double height,
    required double width,
    required List<String> flickerImages,
    required EdgeInsetsGeometry margin}) {
  return Container(
    height: height,
    child: ListView.builder(
        itemCount: flickerImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          return Container(
              height: height,
              width: width,
              margin: margin,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(flickerImages[i]),
                      fit: BoxFit.cover)));
        }),
  );
}
