import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConnection {
  Dio get dioConnection {
    Dio _dio = Dio();
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      compact: false,
    ));
    return _dio;
  }

  Future<Response> get(String url) async {
    return await dioConnection.get(url);
  }

  @override
  void dispose() {}
}
