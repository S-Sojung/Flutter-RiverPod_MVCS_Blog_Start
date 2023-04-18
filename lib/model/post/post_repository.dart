import 'package:dio/dio.dart';
import 'package:flutter_riverpod_blog_start/core/constants/http.dart';
import 'package:flutter_riverpod_blog_start/dto/post_request.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';

class PostRepository {
  static final PostRepository _instance = PostRepository._single();

  factory PostRepository() {
    return _instance;
  }

  PostRepository._single();

  //목적 : 통신 + 파싱
  Future<ResponseDTO> fetchPostList(String jwt) async {
    //여기서 ref 접근 못하게 jwt를 매개변수로 받게끔 해줌
    try {
      //이전 헤더에 추가 헤더를 해야했는데 dio는 추가헤더를 여기서 option으로 넣을 수 있다.
      //Dio 에는 인터셉터가 있어서 특정 주소마다 이걸 요청할 수 있다.
      Response response = await dio.get("/post",
          options: Options(headers: {"Authorization": "$jwt"}));

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      //그냥 다이나믹 타입을 List 다이나믹 타입으로 바꿔줌.
      List<dynamic> mapList = responseDTO.data;
      //필터를 쓸거면 mapList.where //e는 post 처럼 생긴 map
      List<Post> postList = mapList.map((e) => Post.fromJson(e)).toList();
      responseDTO.data = postList;
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchPost(int id, String jwt) async {
    try {
      Response response = await dio.get("/post/${id}",
          options: Options(headers: {"Authorization": "$jwt"}));

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchDelete(int id, String jwt) async {
    try {
      Response response = await dio.delete("/post/${id}",
          options: Options(headers: {"Authorization": "$jwt"}));

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      // responseDTO.data = Post.fromJson(responseDTO.data); //data는 null 이라서 파싱할 필요가 없음
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchUpdate(int id,
      PostUpdateReqDTO postUpdateReqDTO, String jwt) async {
    try {
      Response response = await dio.put(
        "/post/${id}",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postUpdateReqDTO.toJson(),
      );

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      //하나의 데이터라서 이렇게 받을 수 있지만, 나중에는 다른 받는 DTO 를 만들어야 할 수 도 있다.
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }

  Future<ResponseDTO> fetchSave(
      PostSaveReqDTO postSaveReqDTO, String jwt) async {
    try {
      Response response = await dio.post(
        "/post",
        options: Options(headers: {"Authorization": "$jwt"}),
        data: postSaveReqDTO.toJson(),
      );

      ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
      responseDTO.data = Post.fromJson(responseDTO.data);
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "실패 : ${e}");
    }
  }
}
