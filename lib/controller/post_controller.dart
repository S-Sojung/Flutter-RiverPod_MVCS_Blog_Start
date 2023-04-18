import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/post_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/main.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/post_detail_page_view_model.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page_view_model.dart';


final postControllerProvider = Provider<PostController>((ref) {
  return PostController(ref);
});

class PostController{
  // Repository, ViewModel 의존
  final mContext = navigatorKey.currentContext; //최상위 화면: 현재 위치
  final Ref ref;
  PostController(this.ref);

  Future<void> deletePost(int id) async{
    SessionUser sessionUser = ref.read(sessionProvider);
    await PostRepository().fetchDelete(id, sessionUser.jwt!);
    ref.read(postHomePageProvider.notifier).notifyRemove(id);
    Navigator.pop(mContext!);

    // if(responseDTO.code == 1){
    //   //DetailViewModel 은 파괴
    //   //List를 갱신 , init 하던가 delete 하던가.
    //   Navigator.pop(mContext!);
    // }else{
    //   final snackBar = SnackBar(content: Text("글 삭제 실패"));
    //   ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    // }
  }

  Future<void> updatePost(int id, String title, String content) async{
    PostUpdateReqDTO postUpdateReqDTO = PostUpdateReqDTO(title: title, content: content);
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await PostRepository().fetchUpdate(id, postUpdateReqDTO, sessionUser.jwt!);

    ref.read(postDetailPageProvider(id).notifier).notifyUpdate(responseDTO.data);
    ref.read(postHomePageProvider.notifier).notifyUpdate(responseDTO.data);
    Navigator.pop(mContext!);
  }

  Future<void> savePost( String title, String content) async{
    PostSaveReqDTO postSaveReqDTO = PostSaveReqDTO(title: title, content: content);
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await PostRepository().fetchSave(postSaveReqDTO, sessionUser.jwt!);

    ref.read(postHomePageProvider.notifier).notifyAdd(responseDTO.data);
    Navigator.pop(mContext!);
  }

  Future<void> refresh() async{
    SessionUser sessionUser = ref.read(sessionProvider);
    ref.read(postHomePageProvider.notifier).notifyInit(sessionUser.jwt!);
  }
}