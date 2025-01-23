import 'package:logger/logger.dart';

/// 日志工具类
/// 使用方式：l.d('debug'); l.e('error'); l.i('info'); l.w('warning')
class L {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  /// Debug日志
  void d(dynamic message) => _logger.d(message);

  /// Info日志
  void i(dynamic message) => _logger.i(message);

  /// Warning日志
  void w(dynamic message) => _logger.w(message);

  /// Error日志
  void e(dynamic message) => _logger.e(message);

}

/// 全局日志对象
final l = L(); 