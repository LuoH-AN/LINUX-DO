import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
  static const String cfClearance = 'cf_clearance';
  static const String forumSession = '_forum_session';
  static const String tokenKey = '_t';

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
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
        'Accept':
            'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        'Accept-Encoding': 'gzip, deflate, br',
        'Origin': HttpConfig.baseUrl,
        'Referer': HttpConfig.baseUrl,
        'sec-ch-ua':
            '"Chromium";v="122", "Not(A:Brand";v="24", "Google Chrome";v="122"',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'same-origin',
        'sec-fetch-user': '?0',
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
    if (kIsWeb) {
      _cookieJar = CookieJar();
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final cookiePath = '${directory.path}/.cookies/';
      _cookieJar = PersistCookieJar(ignoreExpires: true, storage: FileStorage(cookiePath));
    }
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
    
    /// 处理CF的 cookie
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) async {
        await _handleCookies(response);
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response != null) {
          await _handleCookies(e.response!);
        }
        return handler.next(e);
      },
    ));

    // 添加错误处理拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // 从本地存储获取CSRF Token
        final csrfToken =
            StorageManager.getString(AppConst.identifier.csrfToken);
        if (csrfToken != null && csrfToken.isNotEmpty) {
          l.e('检查 csrfToken : $csrfToken');
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
  }

  Future<void> _handleCookies(Response response) async {
    final cookies = response.headers['set-cookie'];
    if (cookies != null) {
      for (var cookieString in cookies) {
        if (cookieString.contains(cfClearance)) {
          // 解析 CF cookie
          final cfCookie = _parseCfCookie(cookieString);
          if (cfCookie != null) {
            l.e('检查 cfCookie : ${cfCookie.value}');
            await _saveCfCookie(cfCookie);
            l.e('已保存新的 CF cookie: ${cfCookie.value}');

            if (cookieString.contains(forumSession)) {
              final csrfToken = response.headers['x-csrf-token']?.first;
              if (csrfToken != null) {
                _dio.options.headers['X-CSRF-Token'] = csrfToken;
              }
            }
          }
        }
      }
    }
  }

  Cookie? _parseCfCookie(String cookieString) {
    try {
      // 解析 cookie 字符串
      final parts = cookieString.split(';');
      final mainPart = parts[0].trim();
      if (mainPart.startsWith(cfClearance)) {
        final value = mainPart.split('=')[1];
        return Cookie(cfClearance, value)
          ..domain = 'linux.do'
          ..path = '/'
          ..httpOnly = true
          ..secure = true;
      }
    } catch (e) {
      l.e('解析 CF cookie 失败: $e');
    }
    return null;
  }

  Future<void> _saveCfCookie(Cookie cookie) async {
    try {
      // 保存到 cookie jar
      await _cookieJar
          .saveFromResponse(Uri.parse(HttpConfig.baseUrl), [cookie]);
    } catch (e) {
      l.e('保存 CF cookie 失败: $e');
    }
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
