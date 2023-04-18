import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/components/post_home_list_item.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page_view_model.dart';
import 'package:logger/logger.dart';

class PostHomeBody extends ConsumerWidget {
  const PostHomeBody({Key? key}) : super(key: key);

  //버튼을 통해서 데이터를 받아오는 것이 아니기 때문에 View model이 필요하다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger().d("PostHomeBody 그려짐");
    //postHomePageProvider에 접근하면 state를 가져욘다.
    //postHomePageProvider.notifier 에 접근하면 ViewModel을 가져와서 값을 변경할 때 사용.
    // 창고에 접근할 때는 read로 한 번만 읽으면 된다. !
    PostHomePageModel? model = ref.watch(postHomePageProvider);
    List<Post> posts = [];
    if (model != null) {
      posts = model.posts;
    }
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(posts[index].id),
                ));
          },
          child: PostHomeListItem(posts[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
