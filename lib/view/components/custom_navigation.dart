import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/controller/user_controller.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/core/constants/size.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

class CustomNavigation extends ConsumerWidget {
  final scaffoldKey;
  const CustomNavigation(this.scaffoldKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Move.postWritePage);
                  scaffoldKey.currentState!.openEndDrawer();
                  //누르면 닫힘
                },
                child: const Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                  //누르면 닫힘
                },
                child: const Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  scaffoldKey.currentState!.openEndDrawer();
                  // ref.read(sessionProvider).logoutSuccess();
                  ref.read(userControllerProvider).logout();
                  //비지니스 로직이 없으면 그냥 여기서 바로 할 순 있다.
                  //하지만, 로그아웃 후, 화면 이동이 필요하니까 컨트롤러 필요!
                },
                child: const Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
