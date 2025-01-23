import 'package:flutter/material.dart';
import 'utils/sp_util.dart';
import 'utils/device_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App {
  static final App _instance = App.singleton();

  App.singleton();

  static App get instance {
    return _instance;
  }

  /// 初始化App
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // 初始化SharedPreferences
    await SpUtil.init();
    
    // 初始化设备信息
    await DeviceUtil.init();
    
    // 初始化屏幕适配
    await ScreenUtil.ensureScreenSize();
    
    // 添加网络拦截器
    addInterceptor();
  }

  /// 添加网络拦截器
  static void addInterceptor() {
    // TODO: 添加网络拦截器，如token验证、错误处理等
  }
}
