import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/core/constants/move.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/main.dart';
import 'package:flutter_riverpod_blog_start/model/user/user_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';


final userControllerProvider = Provider<UserController>((ref) {
  return UserController(ref);
});

class UserController{
  //IoC 컨테이너에 접근 하는 방법은 ref 뿐이다.
  //Respository와 ViewModel에 의존

  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // navigatorKey: navigatorKey, //MaterialApp 에 넣고, 전역변수로 위에 설정하면 아래처럼 사용가능하다.
  final mContext = navigatorKey.currentContext; //최상위 화면: 현재 위치
  final Ref ref;
  UserController(this.ref);

  Future<void> join(String username, String password, String email) async{
    JoinReqDTO joinReqDTO = JoinReqDTO(username: username, password: password, email: email);
    // ResponseDTO responseDTO = await ref.read(authRepositoryProvider).fetchJoin(joinReqDTO);
    ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);
    if(responseDTO.code == 1){
      Navigator.pushNamed(mContext!, Move.loginPage);
    }else{
      final snackBar = SnackBar(content: Text("회원 가입 실패"));
      ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    }
  }


  Future<void> login(String username, String password) async{

    LoginReqDTO loginReqDTO = LoginReqDTO(username: username, password: password);
    // ResponseDTO responseDTO = await ref.read(authRepositoryProvider).fetchLogin(loginReqDTO);
    ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);
    if(responseDTO.code == 1){
      // 1. 토큰을 휴대폰에 저장. 넣고 이동해야 하기 때문에 await
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 2. 로그인 상태 등록
      ref.read (sessionProvider).loginSuccess(responseDTO.data, responseDTO.token!);

      // 3. 화면 이동
      Navigator.popAndPushNamed(mContext!, Move.postHomePage);
    }else{
      final snackBar = SnackBar(content: Text("로그인 실패 : ${responseDTO.msg}"));
      ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    }
  }

  Future<void> logout() async{
    try {
      await ref.read(sessionProvider).logoutSuccess();
      //로그아웃 처리가 끝난 뒤!!! 화면 이동 해야한다.
      Navigator.pushNamedAndRemoveUntil(mContext!, Move.loginPage, (route) => false);
    }catch(e){
      final snackBar = SnackBar(content: Text("로그아웃 실패"));
      ScaffoldMessenger.of(mContext!).showSnackBar(snackBar);
    }
  }
}