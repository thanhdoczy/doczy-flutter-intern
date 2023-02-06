import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:hive/hive.dart';

class FavoritePodCastService {
  late Box<PodCast> _podcasts;

  Future<void> init() async {
    Hive.registerAdapter(PodCastAdapter());
    _podcasts = await Hive.openBox('favorites');
    _podcasts.clear();
    print('initialed');
  }

  List<PodCast> getPodCasts() {
    final podcasts = _podcasts.values;
    if (podcasts != null) {
      return podcasts.toList();
    }
    return [];
  }
  void addPodCast(PodCast podcast) {
    _podcasts.add(podcast);
  } 
  void removePodCast(PodCast podcast) {
    // final podcastToRemove = _podcasts.values.firstWhere((element) => element == podcast);
    // podcastToRemove.delete();
    final podcasts = _podcasts.values;
    podcasts.toList().remove(podcast);
    _podcasts.put('favorites', podcast);
  }
}