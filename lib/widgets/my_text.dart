import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyText extends StatelessWidget {
  final String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  int maxLines;
  FontStyle fontStyle;
  TextOverflow textOverflow;
  double height;
  MyText(
      {super.key,
      required this.text,
      this.color = Colors.white,
      this.fontSize = 14,
      this.fontWeight = FontWeight.normal,
      this.maxLines = 1,
      this.fontStyle = FontStyle.normal,
      this.textOverflow = TextOverflow.ellipsis,
      this.height = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          height: height),
    );
  }
}
