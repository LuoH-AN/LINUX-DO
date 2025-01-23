import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// 显示加载
  void showLoading() {
    if (!mounted) return;
    setState(() => _isLoading = true);
  }

  /// 隐藏加载
  void hideLoading() {
    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  /// 包装异步方法，自动处理loading状态
  Future<T> wrapLoading<T>(Future<T> Function() task) async {
    try {
      showLoading();
      return await task();
    } finally {
      hideLoading();
    }
  }
} 