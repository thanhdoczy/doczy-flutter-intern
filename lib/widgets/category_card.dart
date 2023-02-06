import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/widgets/my_text.dart';

class CategoryCard extends StatelessWidget {
  final Color beginColor;
  final Color endColor;
  final String title;
  const CategoryCard(
      {super.key,
      required this.beginColor,
      required this.endColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 104,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [beginColor, endColor]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: MyText(
        text: title,
        fontWeight: FontWeight.bold,
      )),
    );
  }
}
