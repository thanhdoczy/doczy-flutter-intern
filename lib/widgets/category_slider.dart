import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/data/models/category.dart';
import 'package:flutter_rewind/widgets/category_card.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class CategorySlider extends StatelessWidget {
  
  final String title;
  final List<Category> categories;
  const CategorySlider({super.key, required this.title, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 6,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
            Spacer(),
            MyText(
              text: 'View all',
              fontSize: 10,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 100,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              margin: index != categories.length - 1
                  ? EdgeInsets.only(right: 10)
                  : EdgeInsets.zero,
              child: CategoryCard(
                  beginColor: categories[index].beginColor,
                  endColor: categories[index].endColor,
                  title: categories[index].title),
            ),
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}
