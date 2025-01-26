import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller/global_controller.dart';
import 'net/api_service.dart';
import 'utils/inject.dart';
import 'utils/storage_manager.dart';
import 'utils/device_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'utils/tag.dart';

class App {
  static final App _instance = App.singleton();

  App.singleton();

  static App get instance {
    return _instance;
  }

  /// 初始化App
  static Future<void> initial() async {
    // 初始化SharedPreferences
    await StorageManager.init();

    // 初始化设备信息
    await DeviceUtil.init();

    // 初始化屏幕适配
    await ScreenUtil.ensureScreenSize();

    // 初始化API服务
    Inject.put<ApiService>(ApiService(Dio()));
    Inject.put<GlobalController>(GlobalController());

    // 添加网络拦截器
    addInterceptor();

    // Tag的颜色
    Tag.initializeFromJson();

    // 测试
    // UserCache().clear();
  }

  /// 添加网络拦截器
  static void addInterceptor() {
    // TODO: 添加网络拦截器，如token验证、错误处理等
  }
}
