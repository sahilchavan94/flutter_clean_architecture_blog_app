import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarouselImageSlider extends StatelessWidget {
  final List<File?> imageList;
  const CarouselImageSlider({
    super.key,
    required this.imageList,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageList.map((file) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .6,
          width: MediaQuery.of(context).size.width,
          child: file == null
              ? const Center(
                  child: Text('No image added'),
                )
              : Image.file(
                  file,
                  fit: BoxFit.cover,
                ),
        );
      }).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * .6,
        viewportFraction: 1,
      ),
    );
  }
}
