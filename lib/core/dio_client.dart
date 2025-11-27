import 'package:dio/dio.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          // Không throw lỗi khi gặp 403/404, để mình tự xử lý
          return status != null && status <= 500;
        },
      ),
    );

    // Logging interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("➡️ REQUEST: ${options.method} ${options.uri}");
          print("Headers: ${options.headers}");
          handler.next(options);
        },
        onResponse: (resp, handler) {
          print("✅ RESPONSE: ${resp.statusCode}");
          handler.next(resp);
        },
        onError: (e, handler) {
          print("❌ ERROR: ${e.response?.statusCode}");
          handler.next(e);
        },
      ),
    );

    return dio;
  }
}
