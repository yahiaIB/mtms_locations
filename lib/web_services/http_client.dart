import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:projects/app/constants.dart';

class HttpClient {
  static Dio? _dio;

  HttpClient(){
    if (_dio == null) {
      BaseOptions options =  BaseOptions(
          baseUrl: Constants.baseUrl,
          connectTimeout: 120 * 1000, // 60 seconds
          receiveTimeout: 120 * 1000 // 60 seconds
      );
      _dio = Dio(options);
      // _dio!.interceptors.add(PrettyDioLogger(
      //     request: true,
      //     responseBody: true,
      //     requestBody: true,
      //     requestHeader: true,
      //   ));
    }
  }

  Dio getInstance() {
    return _dio!;
  }
}
