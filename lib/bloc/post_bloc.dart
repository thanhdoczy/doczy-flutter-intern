import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rewind/data/models/post.dart';
import 'package:flutter_rewind/data/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  int page = 1;
  final PostRepository repo;
  PostBloc(this.repo) : super(PostInitial()) {
    on<PostFetch>((event, emit) {
      _postFetch();
    });
  }
  void _postFetch() async {
    try {
      if (state is PostLoading) {
        print('f');
        return;
      }
      ;

      final currState = state;
      var oldPosts = <Post>[];
      if (currState is PostLoaded) {
        oldPosts = currState.posts;
      }
      emit(PostLoading(oldPosts, isFirstFetch: page == 1));
      print('still loading...');
      final newPosts = await repo.fetchPosts(page);
      page += 1;
      final posts = (state as PostLoading).oldPosts;
      if (newPosts.isEmpty) {
        emit(PostError());
      } else {
        posts.addAll(newPosts);
        emit(PostLoaded(posts));
        print('data loaded');
      }
    } catch (err) {
      emit(PostError());
    }
  }
}
