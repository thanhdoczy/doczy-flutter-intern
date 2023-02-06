part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}
class FavoriteRegisterService extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}
class FavoriteLoaded extends FavoriteState {
  final List<PodCast> podcasts;

  FavoriteLoaded(this.podcasts);
  @override
  // TODO: implement props
  List<Object> get props => [podcasts];
}
class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}
