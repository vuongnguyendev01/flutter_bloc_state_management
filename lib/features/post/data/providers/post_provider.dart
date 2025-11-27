import 'package:dio/dio.dart';
import 'package:trello_app/core/dio_client.dart';

import '../models/post.dart';

class PostProvider {
  final Dio dio = DioClient.createDio();

  Future<List<Post>> getPosts() async {
    final response = await dio.get('/posts');
    return (response.data as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> createPost(Post post) async {
    final response = await dio.post('/posts', data: post.toJson());
    return Post.fromJson(response.data);
  }
}
