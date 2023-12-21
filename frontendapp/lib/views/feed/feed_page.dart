import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/post_controller.dart';
import 'package:frontendapp/views/component/widget/post_data.dart';
import 'package:frontendapp/views/component/widget/post_field.dart';
import 'package:get/get.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final PostController _postController = Get.put(PostController());
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Forum APP',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostField(
                    hintText: 'What you wanna ask?',
                    controller: _textController),
                const SizedBox(height: 8),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 10)),
                    onPressed: () async {
                      await _postController.createPost(
                          content: _textController.text.trim());
                      _textController.clear();
                      _postController.getAllPosts();
                    },
                    child: Obx(() {
                      return _postController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Post',
                              style: TextStyle(color: Colors.white),
                            );
                    })),
                const SizedBox(height: 20),
                const Text('Posts'),
                Obx(() {
                  return _postController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _postController.posts.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                PostData(
                                  post: _postController.posts[index],
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          });
                }),
              ],
            ),
          ),
        ));
  }
}
