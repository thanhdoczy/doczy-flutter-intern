import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/screens/podcast_detail/podcast_detail_screen.dart';
import 'package:flutter_rewind/screens/podcast_detail/podcast_detail_screen2.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_card.dart';

typedef void PodCastCallback(PodCast podcast);

class PodCastSlider extends StatelessWidget {
  PodCastCallback? onSonChanged;
  final String route;
  final String title;
  final List<PodCast> podcasts;
  PodCastSlider(
      {super.key,
      required this.title,
      required this.podcasts,
      required this.route,
      this.onSonChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: title,
                fontWeight: FontWeight.bold,
              ),
              MyText(
                text: 'View all',
                fontSize: 10,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: ((context, index) => GestureDetector(
                    onTap: () => route == '/'
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PodCastDetailScreen2(
                                podcast: podcasts[index],
                              ),
                            ),
                          )
                        : onSonChanged!(podcasts[index]),
                    child: Padding(
                      padding: index != podcasts.length - 1
                          ? const EdgeInsets.only(bottom: 16.0)
                          : EdgeInsets.zero,
                      child: PodCastCard(
                        podcast: podcasts[index],
                      ),
                    ),
                  )),
              itemCount: podcasts.length,
            ),
          ),
        ],
      ),
    );
  }
}
