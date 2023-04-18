
//통신은 무조건 json으로 올것
//json으로 오면 dio가 얘를 map으로 받아준다
//우리는 이걸 object로 파싱해 줄 거니까... 그때 그때 값이 다를 것 이기 때문에 dynamic
class ResponseDTO {
  final int? code;
  final String? msg;
  String? token; //나중에 접근해서 담을 수 있게
  dynamic data; // JsonArray [], JsonObject {}

  ResponseDTO({
    this.code,
    this.msg,
    this.data,
  });

  ResponseDTO.fromJson(Map<String, dynamic> json)
      : code = json["code"],
        msg = json["msg"],
        data = json["data"];
}