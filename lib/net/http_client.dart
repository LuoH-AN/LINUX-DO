import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'api_response.dart';
import 'http_config.dart';
import 'rest_client.dart';

class HttpClient {
  static HttpClient? _instance;
  late final Dio _dio;
  late final RestClient _restClient;

  /// 私有构造函数
  HttpClient._() {
    _dio = Dio(BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: HttpConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: HttpConfig.receiveTimeout),
      sendTimeout: const Duration(milliseconds: HttpConfig.sendTimeout),
    ));
    _initInterceptors();
    _restClient = RestClient(_dio);
  }

  /// 单例模式
  static HttpClient get instance => _instance ??= HttpClient._();

  /// 获取RestClient实例
  RestClient get rest => _restClient;

  /// 初始化拦截器
  void _initInterceptors() {
    // 添加日志拦截器
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    // 添加错误处理拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 在请求之前添加token等通用header
        options.headers['Authorization'] = 'Bearer your_token_here';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 统一处理响应
        return handler.next(response);
      },
      onError: (error, handler) {
        // 统一处理错误
        _handleError(error);
        return handler.next(error);
      },
    ));
  }

  /// 处理错误
  void _handleError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = HttpConfig.timeoutMessage;
        break;
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case HttpConfig.unauthorizedCode:
            message = HttpConfig.unauthorizedMessage;
            // 跳转到登录页
            Get.offAllNamed('/login');
            break;
          case HttpConfig.forbiddenCode:
            message = HttpConfig.forbiddenMessage;
            break;
          case HttpConfig.notFoundCode:
            message = HttpConfig.notFoundMessage;
            break;
          default:
            message = HttpConfig.errorMessage;
        }
        break;
      default:
        message = HttpConfig.networkErrorMessage;
    }
    Get.snackbar('错误', message);
  }

  /// GET请求
  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// POST请求
  Future<ApiResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// PUT请求
  Future<ApiResponse<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// DELETE请求
  Future<ApiResponse<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(dynamic)? fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return ApiResponse<T>.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }
}
