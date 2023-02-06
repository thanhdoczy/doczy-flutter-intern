part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}
class PostLoading extends PostState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostLoading(this.oldPosts, {this.isFirstFetch = false}); 
}
class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded(this.posts);
}
class PostError extends PostState {}
