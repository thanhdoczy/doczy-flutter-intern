import 'package:flutter/material.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/main.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print('aaa');
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              box2.get('favorites') != null
                  ? Expanded(
                      child: PodCastSlider(
                          route: '/detail',
                          title: 'Favorite Podcast Episodes',
                          podcasts: List<PodCast>.from(box2.get('favorites'))),
                    )
                  : Center(child: MyText(text: 'No Favorites Podcast'))
            ],
          ),
        ),
      ),
    );
  }
}
