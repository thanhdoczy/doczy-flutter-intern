import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/main.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class PodCastDetailScreen extends StatefulWidget {
  PodCast podcast;
  static List<PodCast> podcasts = [
    PodCast('The Year in Mograph - 2020', 'assets/images/pod_1.png',
        DateTime(2022, 12, 30), '211'),
    PodCast('Episode 197: The World of Lettering', 'assets/images/pod_2.png',
        DateTime(2020, 12, 2), '42'),
    PodCast('How to Create Youtube Video Ads That Convert',
        'assets/images/pod_3.png', DateTime(2022, 12, 18), '52'),
    PodCast('Airbnb\'s Brian Chesky: Designing for trust',
        'assets/images/pod_4.png', DateTime(2021, 12, 15), '46'),
    PodCast('Sounds Worth Saving', 'assets/images/pod_5.png',
        DateTime(2022, 12, 09), '125'),
  ];
  PodCastDetailScreen({super.key, required this.podcast});

  @override
  State<PodCastDetailScreen> createState() => _PodCastDetailScreenState();
}

class _PodCastDetailScreenState extends State<PodCastDetailScreen> {
  

  final int valueHolder = 20;
  var favorites = box2.get('favorites') ?? List<PodCast>.empty(growable: true);
  bool isFavorite = false;
  void updatePodCast(PodCast newPostCast) {
    setState(() {
      widget.podcast = newPostCast;
    });
    isFavorite = (favorites as List<PodCast>).contains(newPostCast);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavorite = (favorites as List<PodCast>).contains(widget.podcast);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        elevation: 0,
        actions: [
          Icon(Icons.settings_outlined),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal:
                      (MediaQuery.of(context).size.width - 248) / 2 - 16),
              width: 248,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      widget.podcast.image,
                      height: 248,
                      width: 248,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        favorites = List<PodCast>.from(favorites);
                        if (favorites.contains(widget.podcast)) {
                          favorites.remove(widget.podcast);
                          setState(() {
                            isFavorite = false;
                          });
                          box2.put('favorites', favorites);
                          print(favorites.length);
                        } else {
                          favorites.add(widget.podcast);
                          setState(() {
                            isFavorite = true;
                          });
                          print(favorites.length);
                          box2.put('favorites', favorites);
                        }
                      },
                      child: (!isFavorite) ? Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                      ) : Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            MyText(
              text: widget.podcast.title,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            MyText(
              text: 'Twenty Thousand Hertz, Dallas Taylor',
              fontSize: 8,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.shuffle,
                  color: Colors.white,
                  size: 20,
                ),
                Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 22,
                ),
                Icon(
                  Icons.play_circle,
                  color: Colors.white,
                  size: 48,
                ),
                Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 22,
                ),
                Icon(
                  Icons.loop,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: 20,
                    child: Slider(
                      value: valueHolder.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 100,
                      activeColor: Color.fromRGBO(255, 61, 113, 1),
                      inactiveColor: Colors.white,
                      thumbColor: Colors.white,
                      label: '${valueHolder.round()}',
                      onChanged: (double newValue) {
                        // setState(() {
                        //   valueHolder = newValue.round();
                        // });
                      },
                      // semanticFormatterCallback: (double newValue) {
                      //   return '${newValue.round()}';
                      // },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: PodCastSlider(
                  onSonChanged: (podcast) => updatePodCast(podcast),
                  route: '/detail',
                  title: 'Favorite Podcast Episodes',
                  podcasts: PodCastDetailScreen.podcasts),
            )
          ],
        ),
      ),
    );
  }
}
