import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rewind/bloc/favorite_bloc.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class PodCastDetailScreen2 extends StatefulWidget {
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
  PodCastDetailScreen2({super.key, required this.podcast});

  @override
  State<PodCastDetailScreen2> createState() => _PodCastDetailScreenState();
}

class _PodCastDetailScreenState extends State<PodCastDetailScreen2> {
  int valueHolder = 20;
  late List<PodCast> favorites;
  bool isFavorite = false;
  void updatePodCast(PodCast newPostCast) {
    setState(() {
      widget.podcast = newPostCast;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 16,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 10),
        ),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.settings_outlined,
                size: 20,
              ),
            ),
            customBorder: CircleBorder(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.more_vert,
                  size: 24,
                ),
              ),
              customBorder: CircleBorder(),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoaded) {
                  favorites = state.podcasts;
                  isFavorite = favorites.contains(widget.podcast);
                  print('updatepodcast: ${favorites.length}');
                  return Container(
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
                              if (favorites.contains(widget.podcast)) {
                                BlocProvider.of<FavoriteBloc>(context).add(
                                    RemoveItemFavoriteEvent(widget.podcast));
                                setState(() {
                                  isFavorite = false;
                                });
                              } else {
                                BlocProvider.of<FavoriteBloc>(context)
                                    .add(AddItemFavoriteEvent(widget.podcast));
                                setState(() {
                                  isFavorite = true;
                                });
                              }
                            },
                            child: (!isFavorite)
                                ? Icon(
                                    Icons.favorite_outline,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
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
                InkWell(
                  onTap: () {},
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.shuffle,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.play_circle,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  customBorder: CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.loop,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
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
                        setState(() {
                          valueHolder = newValue.round();
                        });
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
                  podcasts: PodCastDetailScreen2.podcasts),
            )
          ],
        ),
      ),
    );
  }
}
