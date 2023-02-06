import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyText extends StatelessWidget {
  final String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  int maxLines;
  MyText(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
