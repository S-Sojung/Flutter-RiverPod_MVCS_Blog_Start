

import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';

void main() async {
  await fetchPostList_test();
}

Future<void> fetchPostList_test() async {
  String jwt = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJjb3PthqDtgbAiLCJpZCI6MSwiZXhwIjoxNjgyNjQ4NDA1fQ.ZkFvmahhc4qN6er3vNhsCg7ol_ijjK-y_Pyz_smKpdKy3JwZDzzhR5PS1NLklbJinqFkzTrp24pD-aZB8_w16A";
  ResponseDTO responseDTO =await PostRepository().fetchPostList(jwt);
  print(responseDTO.code);
  print(responseDTO.msg);
  List<Post> postList = responseDTO.data;
  postList.forEach((element) {
    print(element.title);
  });
}
