import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';

class RetroBase {
  Dio dioData() {
    return dio.Dio(BaseOptions(
      contentType: "application/json",
    ));
  }
}
