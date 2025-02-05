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
import 'dart:async';

import '../web_page.dart';

class LoginController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();
  final GlobalController _globalController = Get.find<GlobalController>();
  final username = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;
  final isChecking = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // 检查是否已登录
    isChecking.value = true;
    try {
      await _globalController.checkLoginStatus();
      if (_globalController.isLogin) {
        isChecking.value = false;
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      l.e('检查登录状态失败: $e');
    } finally {
      isChecking.value = false;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void webLogin() async {
    final result = await Get.to(() => const WebPage());
    if (result == true) {
      isLoading.value = true;
      try {
        // 保存登录状态
        Get.find<GlobalController>().setIsLogin(true);
        // 跳转到首页
        Get.offAllNamed('/home');
      } catch (e) {
        showSnackbar(
          title: AppConst.login.loginFailedTitle,
          message: AppConst.login.loginFailedMessage,
          type: SnackbarType.error,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> login() async {
    await _apiService.getTopics('latest');

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
          timezone: 'Asia/Shanghai');

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
