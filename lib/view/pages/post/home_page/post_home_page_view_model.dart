
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

//autoDispose : 페이지가 pop되면 자동으로 소멸 시켜준다.
//관리자 : 창고를 관리함
final postHomePageProvider = StateNotifierProvider.autoDispose<PostHomePageViewModel, PostHomePageModel?>((ref) {
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostHomePageViewModel(null)..notifyInit(sessionUser.jwt!);
  //watch를 통해서 대기하고 있다가 값이 들어오면 바로 다시 그려진다.
});


//창고 데이터
//이 데이터의 형태가 하나가 아닐 수 도 있기 때문에 따로 이렇게 관리하는 것.
// 일관성 유지를 위해서 !
class PostHomePageModel{
  List<Post> posts;
  PostHomePageModel({required this.posts});
}


//창고 : Store
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  //창고 초기화 : 집어 넣을 필요없이 창고에서 들고오는 값이기 때문에 직접 통신
  // void notifyInit(List<Post> newPosts){
  void notifyInit(String jwt) async{
    ResponseDTO responseDTO = await PostRepository().fetchPostList(jwt);
    state = PostHomePageModel(posts: responseDTO.data);
  }

  //추가 : 창고가 List형태(컬렉션) 이 아니라면 필요없다.
  void notifyAdd(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = [...posts, post]; //정규연산자 사용해서 기존값 뒤에 넣어줌.
    state = PostHomePageModel(posts: newPosts);
  }
  //삭제
  void notifyRemove(int id){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    //true 인 값만 toList에 넣어준다.
    state = PostHomePageModel(posts: newPosts);
  }
  //수정
  void notifyUpdate(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }
}

