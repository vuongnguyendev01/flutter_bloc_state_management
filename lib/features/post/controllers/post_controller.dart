import 'package:get/get.dart';
import '../data/models/post.dart';
import '../data/repositories/post_repository.dart';

class PostController extends GetxController {
  final PostRepository repository = PostRepository();
  var posts = <Post>[].obs;
  var isLoading = false.obs;

  Future<void> loadPosts() async {
    isLoading.value = true;
    posts.value = await repository.fetchPosts();
    isLoading.value = false;
  }

  Future<void> addPost(String title, String body) async {
    final newPost = Post(id: 0, title: title, body: body);
    final created = await repository.addPost(newPost);
    posts.add(created);
  }
}
