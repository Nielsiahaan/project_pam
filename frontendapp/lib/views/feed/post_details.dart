import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/post_controller.dart';
import 'package:frontendapp/models/post_model.dart';
import 'package:frontendapp/views/component/widget/input_widget.dart';
import 'package:frontendapp/views/component/widget/post_data.dart';
import 'package:get/get.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({Key? key, required this.post}) : super(key: key);
  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.post.mahasiswa.name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 380,
                  child: Obx(() {
                    return _postController.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : ListView.builder(
                            itemCount: _postController.comments.value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_postController
                                    .comments.value[index].mahasiswa.name),
                                subtitle: Text(
                                    _postController.comments.value[index].body),
                              );
                            });
                  })),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                  controller: _commentController,
                  hintText: 'Write a comment',
                  obscureText: false),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10)),
                  onPressed: () async {
                    await _postController.createComment(
                        widget.post.id, _commentController.text.trim());
                        _commentController.clear();
                        _postController.getComments(widget.post.id);
                  },
                  child: const Text('Comment'))
            ],
          ),
        ),
      ),
    );
  }
}
