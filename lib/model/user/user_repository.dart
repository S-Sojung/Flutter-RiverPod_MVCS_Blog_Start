
import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:logger/logger.dart';

import 'user.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._single();
  factory UserRepository() {
    return _instance;
  }
  UserRepository._single();

  Future<SessionUser> fetchJwtVerify() async {
    SessionUser sessionUser = SessionUser();
    //앱이 제일 처음 켜질 때 얘가 실행 된다.
    String? deviceJwt = await secureStorage.read(key: "jwt");
    // Logger().d("토큰 : "+deviceJwt!);
    //이게 없다면? deviceJwt을 Base64로 디코딩 - payload값에 id를 확인해서 요청
    if(deviceJwt != null){
      try{
        //jwtToken 을 요청하면 인증 정보를 보내줌 
        Response response = await dio.get("/jwtToken", options: Options(
            headers: {
              "Authorization" : "$deviceJwt"
            }
        ));
        ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
        responseDTO.token = deviceJwt;
        responseDTO.data = User.fromJson(responseDTO.data);


        if(responseDTO.code == 1){
          sessionUser.loginSuccess(responseDTO.data, responseDTO.token!);
        }else{
          sessionUser.logoutSuccess();
        }
        return sessionUser;
      }catch(e){
        Logger().d("에러 이유 : "+e.toString());
        sessionUser.logoutSuccess();
        return sessionUser;
        // return ResponseDTO(code: -1, msg: "jwt토큰이 유효하지 않습니다.");
      }
    }else{
      sessionUser.logoutSuccess();
      return sessionUser;
      // return ResponseDTO(code: -1, msg: "jwt토큰이 존재하지 않습니다.");
    }
  }

  Future<ResponseDTO> fetchJoin(JoinReqDTO joinReqDTO) async {
    try{
      Response response = await dio.post("/join", data: joinReqDTO.toJson());
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);
      return responseDTO;
    }catch(e){
      //만약 서버에서 이걸 안주면 이렇게 임의로 만들어야 함.
      return ResponseDTO(code: -1, msg: "유저네임 중복");
    }

  }

  Future<ResponseDTO> fetchLogin(LoginReqDTO loginReqDTO) async {
    try{
      // 1. 통신 시작
      Response response = await dio.post("/login", data: loginReqDTO.toJson());

      // 2. DTO 파싱
      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = User.fromJson(responseDTO.data);

      // 3. 토큰 받기
      final authorization = response.headers["authorization"];
      if(authorization != null){
        responseDTO.token = authorization.first;
      }
      return responseDTO;
    }catch(e){
      return ResponseDTO(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }
}