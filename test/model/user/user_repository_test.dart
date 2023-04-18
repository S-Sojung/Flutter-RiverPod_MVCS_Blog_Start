// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
//
// final dio = Dio(BaseOptions(
//   baseUrl: "http://192.168.200.171:8080",
//   contentType: "application/json; charset=utf-8",
//
// ));
//
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/model/user/user_repository.dart';

void main() async {
  // await fetchJoin_test();
  await fetchLogin_test();

}

Future<void> fetchJoin_test() async {
  ResponseDTO responseDTO = await UserRepository().fetchJoin(JoinReqDTO(username: "meta", password: "1234", email: "meta@nate.com"));
  print(responseDTO.code);
  print(responseDTO.msg);
}

Future<void> fetchLogin_test() async {
  LoginReqDTO loginReqDTO = LoginReqDTO(username: "ssar", password: "1234");
  ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);
  print(responseDTO.code);
  print(responseDTO.msg);
  print(responseDTO.token);
}
//
// Future<void> fetchJoin_test() async {
//   //이렇게 할 수 없음, 생성자에 ref같은 매개변수 들어갈 경우 생성 불가
//   // AuthRepository authRepository = AuthRepository();
//   // given
//   String username = "gildong3";
//   String password = "1234";
//   String email = "gildong3@nate.com";
//
//   //when
//   Map<String, dynamic> requestBody = {
//     "username" : username,
//     "password" : password,
//     "email" : email
//   };
//   // 요청 시에는 map을 body에 담기 (dio가 json으로 변경해준다)
//   // 응답 시에는 response.data에 map을 담아줌 (dio가 json을 map으로 변경해서 담아준다)
//   Response response = await dio.post("/join",data: requestBody);
//   // print(response.data);
//   ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
//   // User user = User.fromJson(responseDTO.data); //이건 안됨!!
//   // ResponseDTO 를
//   responseDTO.data = User.fromJson(responseDTO.data);
//
//   // print(responseDTO.code);
//   // print(responseDTO.msg);
//   // print(responseDTO.data);
//   // User user = responseDTO.data;
//   // print(user.username);
//
// }
//
// Future<void> fetchLogin_test() async{
//   // given
//   String username = "ssar";
//   String password = "1234";
//
//   // when
//   Map<String, dynamic> requestBody = {
//     "username" : username,
//     "password" : password,
//   };
//
//   // 1. 통신 시작
//   Response response = await dio.post("/login",data: requestBody);
//
//   // 2. DTO 파싱
//   ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
//   responseDTO.data = User.fromJson(responseDTO.data);
//
//   // 3. 토큰 받기
//   responseDTO.token = response.headers["authorization"].toString();
//
//   print(responseDTO.code);
//   print(responseDTO.msg);
//   print(responseDTO.token);
//   User user = responseDTO.data;
//   print(user.id);
//   print(user.username);
// }