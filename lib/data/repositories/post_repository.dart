import 'package:flutter_rewind/data/models/post.dart';
import 'package:flutter_rewind/data/services/post_service.dart';

class PostRepository {
  final PostService service;

  PostRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
    return await service.fetchPosts(page);
  }
}