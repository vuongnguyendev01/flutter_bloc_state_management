import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class PostPage extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadPosts();

    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (_, index) {
            final post = controller.posts[index];
            return ListTile(title: Text(post.title), subtitle: Text(post.body));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addPost("New Post", "This is a new post body");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
