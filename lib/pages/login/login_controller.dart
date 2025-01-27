import 'package:get/get.dart';
import 'package:linux_do/controller/base_controller.dart';
import 'package:linux_do/models/login.dart';
import 'package:linux_do/net/api_service.dart';
import 'package:linux_do/routes/app_pages.dart';
import '../../const/app_const.dart';
import '../../utils/mixins/toast_mixin.dart';
import '../../utils/log.dart';
import '../../controller/global_controller.dart';
import 'package:dio/dio.dart';
import '../../net/http_config.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/foundation.dart';
import '../../utils/web_stub.dart' if (dart.library.html) '../../utils/web.dart';
import 'dart:async';

class LoginController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final username = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 检查是否已登录
    if (_globalController.isLogin) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// 检查登录状态
  Future<void> checkLoginStatus() async {
    try {
      // 等待一段时间让 cookie 生效
      await Future.delayed(const Duration(seconds: 1));
      
      final response = await _apiService.getCurrentUser();
      if (response != null) {
        l.e('用户信息 $response');
        // 登录成功,保存用户信息
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      showSnackbar(
        title: AppConst.login.loginFailedTitle,
        message: '请先在浏览器中完成登录',
        type: SnackbarType.error,
      );
    }
  }

  void webLogin() async {
    final url = Uri.parse('${HttpConfig.baseUrl}login');
    if (kIsWeb) {
      openNewWindow(url.toString(), '_blank');
      // 检查登录状态
      Timer.periodic(const Duration(seconds: 2), (timer) async {
        await checkLoginStatus();
        timer.cancel();
      });
    } else {
      if (await url_launcher.canLaunchUrl(url)) {
        await url_launcher.launchUrl(
          url,
          mode: url_launcher.LaunchMode.externalApplication,
        );
        // 用户从浏览器返回后检查登录状态
        await checkLoginStatus();
      } else {
        showSnackbar(
          title: AppConst.login.loginFailedTitle,
          message: '无法打开浏览器',
          type: SnackbarType.error,
        );
      }
    }
  }

  Future<void> login() async {
    // 检查是否已登录
    if (_globalController.isLogin) {
      Get.offAllNamed(Routes.HOME);
      return;
    }

    if (username.value.isEmpty) {
      showSnackbar(
        title: AppConst.login.title,
        message: AppConst.login.emptyUsername,
        type: SnackbarType.error,
      );
      return;
    }
    if (password.value.isEmpty) {
      showSnackbar(
        title: AppConst.login.title,
        message: AppConst.login.emptyPassword,
        type: SnackbarType.error,
      );
      return;
    }

    try {
      isLoading.value = true;

      // 1. 先获取 CSRF Token
      await _apiService.getCsrfToken();

      // 2. 构建登录请求
      final loginRequest = LoginRequest(
        login: username.value,
        password: password.value,
        secondFactorMethod: 1,
        timezone: 'Asia/Shanghai'
      );

      // 3. 发起登录请求
      await _apiService.login(loginRequest);

        // 设置登录状态
        _globalController.setIsLogin(true);

        showSnackbar(
          title: AppConst.login.loginSuccessTitle,
          message: AppConst.login.welcomeBack,
          type: SnackbarType.success,
        );

        // 延迟跳转，让用户看到成功提示
        await Future.delayed(const Duration(milliseconds: 1500));
        Get.offAllNamed(Routes.HOME);
    } catch (e) {
      l.e('登录失败: $e');
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          showSnackbar(
            title: AppConst.login.loginFailedTitle,
            message: '请先在浏览器中完成验证后再试',
            type: SnackbarType.error,
          );
          return;
        }
      }
      showSnackbar(
        title: AppConst.login.loginFailedTitle,
        message: AppConst.login.networkError,
        type: SnackbarType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void forgetPassword() {
    showSnackbar(
      title: AppConst.login.title,
      message: AppConst.login.notImplemented,
      type: SnackbarType.warning,
    );
  }

  void reigster() {
    showSnackbar(
      title: AppConst.login.register,
      message: AppConst.login.registerTip,
      type: SnackbarType.info,
    );
  }
}
