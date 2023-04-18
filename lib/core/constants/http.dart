
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


//baseoption은 고정이기 때문에 core/constanct/http
final dio = Dio(BaseOptions(
  baseUrl: "http://192.168.200.171:8080",
  contentType: "application/json; charset=utf-8",
));

//휴대폰 앱 내의 임시 공간에 접근 가능
const secureStorage = FlutterSecureStorage();