import 'package:dio/dio.dart';

class APIRequester {
  static final APIRequester instance = APIRequester._();

  late Dio dio;

  APIRequester._() {
    dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Response ${response.data}');
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    );
  }
}