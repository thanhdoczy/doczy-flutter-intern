import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rewind/data/models/podcast.dart';
import 'package:flutter_rewind/data/services/favorite_podcast_service.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoritePodCastService _favoritePodCastService;
  FavoriteBloc(this._favoritePodCastService) : super(FavoriteInitial()) {
    on<FetchFavoriteEvent>((event, emit) {
      // TODO: implement event handler
      final podcasts = _favoritePodCastService.getPodCasts();
      emit(FavoriteLoaded(podcasts));
    });
    on<AddItemFavoriteEvent>((event, emit) {
      // TODO: implement event handler
      final currState = state;
      var podcasts = <PodCast>[];
      if (currState is FavoriteLoaded) {
        podcasts = currState.podcasts;
        _favoritePodCastService.addPodCast(event.podcast);
        podcasts.add(event.podcast);
        emit(FavoriteLoaded(podcasts));
      }
    });
    on<RemoveItemFavoriteEvent>((event, emit) {
      // TODO: implement event handler
      final curState = state;
      var podcasts = <PodCast>[];
      if (curState is FavoriteLoaded) {
        podcasts = curState.podcasts;
        _favoritePodCastService.removePodCast(event.podcast);
        podcasts.remove(event.podcast);
        emit(FavoriteLoaded(podcasts));
      }
    });
    on<RegisterServiceFavoriteEvent>((event, emit) async{
      // TODO: implement event handler
      await _favoritePodCastService.init();
      emit(FavoriteRegisterService());
    });
  }
}
