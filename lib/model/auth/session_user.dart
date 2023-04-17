import 'package:flutter_riverpod_blog_start/model/user/user.dart';


//모바일 하드디스크, 앱 마다의 개인 저장소, 모바일의 SQLite
//앱 마다의 개인 저장소 (shared preparence 앱을 삭제하면 사라지지만, 안하면 계속 남아있음) : flutter 시큐어 store 사용하면 보안 괜찮음
//앱이 켜지자마자 토큰을 확인함 : secure store 에서 값을 들고와야하니까 비동기 통신 해야함
//하지만 모든 첫 시작은 일의 순서가 있기 때문에 동기화 한다. wait 해서 끝까지 기다렷다가 다 다운 받은 후 넘어가야한다.

//최초 앱이 실행될 때 초기화 되어야 함.
// 1. JWT 존재 유무 확인 (I/O)
// 2. JWT로 회원정보 받아봄 (I/O)
// 3. OK -> LoginSuccess() 호출
// 4. FAIL -> LoginPage로 이동.
class SessionUser {
  //실제로 세션에 넣진 않고, 프로바이더에 넣으면 된다.
  User? user;
  String? jwt;
  bool? isLogin;
  //getter setter 를 써야하지만 지금은 그냥 접근하기


  void loginSuccess(User user, String jwt, bool isLogin){
    this.user = user;
    this.jwt = jwt;
    this.isLogin = true;
    //1이 들어와서 성공하면 이렇게 받으면 된다.
  }

  void logoutSuccess(){
    this.user = null;
    this.jwt = null;
    this.isLogin = false;
  }
}