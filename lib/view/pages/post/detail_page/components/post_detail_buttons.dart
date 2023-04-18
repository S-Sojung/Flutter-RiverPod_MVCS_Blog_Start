import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/controller/post_controller.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/detail_page/post_detail_page_view_model.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/update_page/post_update_page.dart';

class PostDetailButtons extends ConsumerWidget {
  final Post post;
  const PostDetailButtons(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () async {
            // ref.watch(postDetailPageProvider(post.id).notifier).notifyRemove(post.id);
            ref.read(postControllerProvider).deletePost(post.id);
            //밑에 할 일이 있으면 awaite 걸어서 기다리게 해준다.
          },
          child: const Text("삭제"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostUpdatePage(post),
              ),
            );
          },
          child: const Text("수정"),
        ),
      ],
    );
  }
}
