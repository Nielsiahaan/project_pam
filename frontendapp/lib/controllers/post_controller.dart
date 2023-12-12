import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/comment_model.dart';
import 'package:frontendapp/models/post_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  RxList<PostModel> posts = RxList<PostModel>();
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        var postList = (json.decode(response.body)['feeds'] as List)
            .map((item) => PostModel.fromJson(item))
            .toList();
        posts.assignAll(postList);
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      var data = {'content': content};
      var response = await http.post(Uri.parse('${url}feed/store'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);
      if (response.statusCode == 201) {
        debugPrint(json.decode(response.body).toString());
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;
      var response =
          await http.get(Uri.parse('${url}feed/comments/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['comments'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future createComment(id, body) async {
    try {
      isLoading.value = true;
      var data = {'body': body};
      var request = await http.post(Uri.parse('${url}feed/comment/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);
      if (request.statusCode == 201) {
        debugPrint(json.decode(request.body).toString());
      } else {
        Get.snackbar('Error', json.decode(request.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future likeAndDislike(id) async {
    try {
      isLoading.value = true;
      var request = await http.post(Uri.parse('${url}feed/like/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Liked') {
        isLoading.value = false;

        debugPrint(json.decode(request.body).toString());
      } else if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Unliked') {
        isLoading.value = false;

        debugPrint(json.decode(request.body).toString());
      } else {
        isLoading.value = false;
        debugPrint(json.decode(request.body).toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
