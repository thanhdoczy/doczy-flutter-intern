import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rewind/bloc/favorite_bloc.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/main.dart';
import 'package:flutter_rewind/widgets/my_text.dart';
import 'package:flutter_rewind/widgets/podcast_slider.dart';

class FavoriteScreen2 extends StatelessWidget {
  const FavoriteScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    print('aaa');
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoaded) {
          final podcasts = state.podcasts;
          return Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  podcasts != []
                      ? Expanded(
                          child: PodCastSlider(
                              route: '/detail',
                              title: 'Favorite Podcast Episodes',
                              podcasts:
                                  podcasts),
                        )
                      : Center(child: MyText(text: 'No Favorites Podcast'))
                ],
              ),
            ),
          ),
        );
        }
        return Container();
      },
    );
  }
}
