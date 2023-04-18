import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/model/user/user_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //MyApp 시작 전에 필요한 것 여기서 다 로딩
  //무조건 동기적 실행.
  //runApp 전에 있는 코드 중, 비동기가 있다면, 다 완료후, 그림을 그려라.
  WidgetsFlutterBinding.ensureInitialized();

  // 1. 시큐어 스토리지에 jwt 있는지 확인, 없으면 바로 로그인 페이지
  // String? jwt = await secureStorage.read(key: "jwt");
  // 2. jwt가 있다면? 이 jwt 회원 정보를 가져오기
  // 3. SessionUser 동기화 (ref에 접근해야함)

  SessionUser sessionUser = await UserRepository().fetchJwtVerify();

  //어처피 혼자쓰는 앱이기 때문에 굳이 세션에 관리 할 필요 없이 static 쓸 수도 있다.
  runApp(
    ProviderScope(
      overrides: [
        sessionProvider.overrideWithValue(sessionUser)
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //단 한 번만 로그인 상태를 읽음
    SessionUser sessionUser = ref.read(sessionProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: sessionUser.isLogin! ? Move.postHomePage : Move.loginPage,
      routes: getRouters(),
    );
  }
}