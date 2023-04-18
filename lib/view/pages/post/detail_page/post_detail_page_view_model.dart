
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page_view_model.dart';
import 'package:logger/logger.dart';

//autoDispose : 페이지가 pop되면 자동으로 소멸 시켜준다.
//family <, ,family의 데이터 타입>(ref, 받아올 매개변수)
//관리자 : 창고를 관리함
final postDetailPageProvider = StateNotifierProvider.family.autoDispose<PostDetailPageViewModel, PostDetailPageModel?,int>((ref, postId) {
  Logger().d("postDetailPageProvider");
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostDetailPageViewModel(null, ref)..notifyInit(postId, sessionUser.jwt!);
  //watch를 통해서 대기하고 있다가 값이 들어오면 바로 다시 그려진다.
});


//창고 데이터
class PostDetailPageModel{
  Post post;
  PostDetailPageModel({required this.post});
}


//창고 : Store
class PostDetailPageViewModel extends StateNotifier<PostDetailPageModel?>{
  Ref ref;
  PostDetailPageViewModel(super.state, this.ref);

  //창고 초기화 : 집어 넣을 필요없이 창고에서 들고오는 값이기 때문에 직접 통신
  void notifyInit(int id, String jwt) async{
    ResponseDTO responseDTO = await PostRepository().fetchPost(id, jwt);
    state = PostDetailPageModel(post: responseDTO.data);
  }

  //추가 : 창고가 List형태(컬렉션) 이 아니라면 필요없다.

  //삭제 -> 리스트도 삭제 해줘야함
  void notifyRemove(int id){
    Post post = state!.post;
    if(post.id == id){
      state = null;
      // ref.read(postHomePageProvider.notifier).notifyRemove(id);
      //push한 것이기 때문에 뒤로가기 시 적용이 되어야함.
      //하지만 이런 비지니스 로직은 컨트롤러에서
    }
    //true 인 값만 toList에 넣어준다.
  }

  //api 수정 요청 -> 수정된 post를 돌려받음
  //수정 -> 리스트도 수정 해줘야함
  void notifyUpdate(Post updatePost){
    state = PostDetailPageModel(post: updatePost);
    // ref.read(postHomePageProvider.notifier).notifyUpdate(updatePost);
    // 이런 비지니스 로직은 컨트롤러에서
  }
}

