import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/widgets/my_text.dart';

class PodCastCard extends StatelessWidget {
  final PodCast podcast;
  const PodCastCard({super.key, required this.podcast});

  @override
  Widget build(BuildContext context) {
    late final time = int.parse(podcast.time);
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                podcast.image,
                width: 50,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    MyText(
                      text: 'DEC 30, 2020',
                      fontSize: 8,
                      color: Colors.white70,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MyText(
                      text: time > 60
                          ? (time % 60 > 0
                              ? '${(time / 60).round()} hr ${(time % 60)} min'
                              : '${(time / 60)} hr')
                          : '${time} min',
                      fontSize: 8,
                    ),
                  ],
                ),
                MyText(
                  text: podcast.title,
                  maxLines: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 16,
            child: PopupMenuButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(child: MyText(text: 'Popup 1')),
                      PopupMenuItem(child: MyText(text: 'Popup 2')),
                      PopupMenuItem(child: MyText(text: 'Popup 3')),
                    ]),
          )
        ],
      ),
    );
  }
}
