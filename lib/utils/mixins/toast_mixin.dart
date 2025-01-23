import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin ToastMixin {
  /// 显示toast提示
  void showToast(
    String message, {
    Toast length = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    double fontSize = 16.0,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  /// 显示成功toast
  void showSuccess(String message) {
    showToast(
      message,
      backgroundColor: Colors.green,
    );
  }

  /// 显示错误toast
  void showError(String message) {
    showToast(
      message,
      backgroundColor: Colors.red,
    );
  }

  /// 显示警告toast
  void showWarning(String message) {
    showToast(
      message,
      backgroundColor: Colors.orange,
    );
  }
} 