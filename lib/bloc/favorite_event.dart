part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}
class RegisterServiceFavoriteEvent extends FavoriteEvent {}

class FetchFavoriteEvent extends FavoriteEvent {}
class AddItemFavoriteEvent extends FavoriteEvent {
  final PodCast podcast;

  AddItemFavoriteEvent(this.podcast);
}
class RemoveItemFavoriteEvent extends FavoriteEvent {
  final PodCast podcast;

  RemoveItemFavoriteEvent(this.podcast);
}
