import '../models/post.dart';
import '../providers/post_provider.dart';

class PostRepository {
  final PostProvider provider = PostProvider();

  Future<List<Post>> fetchPosts() => provider.getPosts();
  Future<Post> addPost(Post post) => provider.createPost(post);
}
