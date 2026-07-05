import 'package:dio/dio.dart';
import 'package:plexus_task/core/services/storage_service.dart';

class NetworkCaller {
  static final Dio dio = _initDio();

  static Dio _initDio() {
    final dioInstance = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = StorageService.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            StorageService.logoutUser();
          }
          return handler.next(e);
        },
      ),
    );

    return dioInstance;
  }

  static Future<Response> getRequest({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Response> postRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Response> putRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Response> patchRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.patch(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Response> deleteRequest({
    required String url,
    dynamic body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
