import 'package:dio/dio.dart';

class APIRequester {
  static final APIRequester instance = APIRequester._();

  late Dio dio;

  APIRequester._() {
    dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] = "Bearer 0b-I-PseXIpjDG_dU7_q2549MI1JXGPjGDKZaffi5s8";
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