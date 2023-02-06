import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_rewind/data/models/post.dart';

class PostService {
  final Dio _dio = Dio();
  final String _url = 'http://18.218.244.144/intern/apis/news';

  Future<List<Post>> fetchPosts(int page) async {
    try {
      List<Post> result = [];
      final response = await _dio.get('$_url?page=$page');
        final jsonResponse = response.data;
        result =  jsonResponse
            .map((e) => Post.fromJson(e)).cast<Post>()
            .toList();
      return result;
    } catch (error, stacktrace) {
      // if (kDebugMode) {
      //   print('Exception occured: $error, stackTrace: $stacktrace');
      // }
      return [];
    }
  }
}
