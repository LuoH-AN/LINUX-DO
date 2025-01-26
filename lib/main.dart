import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'routes/app_pages.dart';
import 'const/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 强制竖屏
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 初始化App
  await App.initial();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配
    return ScreenUtilInit(
      designSize: const Size(375, 812), // 没有设计稿,自由发挥吧~
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Linux DO',
          debugShowCheckedModeBanner: false,

          // 主题配置
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system, // 跟随系统主题

          // 路由配置
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,

          // 默认转场动画
          defaultTransition: Transition.cupertino,

          // 错误页面
          unknownRoute: GetPage(
            name: '/notfound',
            page: () => const Scaffold(
              body: Center(
                child: Text('页面不存在'),
              ),
            ),
          ),

          // 全局设置
          builder: (context, child) {
            // 获取当前主题模式
            final isDark = Theme.of(context).brightness == Brightness.dark;

            // 根据主题设置系统UI样式
            if (Platform.isAndroid) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    isDark ? Brightness.light : Brightness.dark,
                systemNavigationBarColor:
                    isDark ? const Color(0xFF121212) : Colors.white,
                systemNavigationBarIconBrightness:
                    isDark ? Brightness.light : Brightness.dark,
                systemNavigationBarDividerColor: Colors.transparent,
              ));
            }

            return GestureDetector(
                // 点击空白处收起键盘
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: child!,
              );
          },
        );
      },
    );
  }
}
