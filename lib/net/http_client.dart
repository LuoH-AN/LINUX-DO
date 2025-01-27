import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'api_response.dart';
import 'http_config.dart';
import '../controller/global_controller.dart';
import '../const/app_const.dart';
import '../utils/storage_manager.dart';
import '../utils/log.dart';

class HttpClient {
  static HttpClient? _instance;
  late final Dio _dio;
  late final CookieJar _cookieJar;
  late final BaseOptions _options;

  /// 获取dio实例
  Dio get dio => _dio;

  /// 获取options
  BaseOptions get options => _options;

  /// 静态方法获取dio实例
  static Dio get getDio {
    if (_instance == null) {
      throw Exception('HttpClient not initialized');
    }
    return _instance!._dio;
  }

  /// 静态方法获取options
  static BaseOptions get getOptions {
    if (_instance == null) {
      throw Exception('HttpClient not initialized');
    }
    return _instance!._options;
  }

  /// 私有构造函数
  HttpClient._() {
    _initOptions();
    _initCookieManager();
    _initInterceptors();
  }

  /// 初始化options
  void _initOptions() {
    _options = BaseOptions(
      baseUrl: HttpConfig.baseUrl,
      connectTimeout: const Duration(milliseconds: HttpConfig.connectTimeout),
      receiveTimeout: const Duration(milliseconds: HttpConfig.receiveTimeout),
      sendTimeout: const Duration(milliseconds: HttpConfig.sendTimeout),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        'X-Requested-With': 'XMLHttpRequest',
      },
      contentType: 'application/x-www-form-urlencoded',
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status != null && status >= 200 && status < 500;
      },
    );
    _dio = Dio(_options);
  }

  /// 初始化Cookie管理器
  Future<void> _initCookieManager() async {
    final directory = await getApplicationDocumentsDirectory();
    final cookiePath = '${directory.path}/.cookies/';
    _cookieJar =
        PersistCookieJar(ignoreExpires: true, storage: FileStorage(cookiePath));
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  /// 单例模式
  static Future<HttpClient> getInstance() async {
    _instance ??= HttpClient._();
    return _instance!;
  }

  /// 清除所有Cookie
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }

  /// 初始化拦截器
  void _initInterceptors() {
    // 添加日志拦截器
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          l.d('Request: ${options.method} ${options.uri}');
          l.d('Headers: ${options.headers}');
          l.d('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          l.d('Response: ${response.statusCode}');
          l.d('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          l.e('Error: ${error.message}');
          if (error.response != null) {
            l.e('Response: ${error.response?.data}');
          }
          return handler.next(error);
        },
      ),
    );

    // 添加错误处理拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 从本地存储获取CSRF Token
        final csrfToken =
            StorageManager.getString(AppConst.identifier.csrfToken);
        if (csrfToken != null && csrfToken.isNotEmpty) {
          options.headers['X-CSRF-Token'] = csrfToken;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        try {
          // 检查并保存CSRF Token
          final csrfToken = response.headers.value('X-CSRF-Token');
          if (csrfToken != null) {
            StorageManager.setData(AppConst.identifier.csrfToken, csrfToken);
          }
        } catch (e) {
          l.e('处理响应头错误: $e');
        }
        return handler.next(response);
      },
      onError: (error, handler) {
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
            // 清除登录状态
            StorageManager.remove(AppConst.identifier.csrfToken);
            clearCookies(); // 清除Cookie
            Get.find<GlobalController>().setIsLogin(false);
            Get.offAllNamed('/login');
            break;
          case HttpConfig.forbiddenCode:
            message = HttpConfig.forbiddenMessage;
            break;
          case HttpConfig.notFoundCode:
            message = HttpConfig.notFoundMessage;
            break;
          default:
            message = error.response?.data?['error'] ?? HttpConfig.errorMessage;
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
