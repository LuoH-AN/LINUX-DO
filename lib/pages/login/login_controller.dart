import 'package:get/get.dart';
import 'package:linux_do/controller/base_controller.dart';
import 'package:linux_do/models/login.dart';
import 'package:linux_do/net/api_service.dart';
import 'package:linux_do/routes/app_pages.dart';
import '../../const/app_const.dart';
import '../../net/http_client.dart';
import '../../utils/mixins/toast_mixin.dart';
import '../../utils/log.dart';
import '../../utils/storage_manager.dart';
import '../../controller/global_controller.dart';

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
        authenticityToken: '',
      );

      // 3. 发起登录请求
      final response = await _apiService.login(loginRequest);
      l.d(response.toJson().toString());

      // 4. 处理登录响应
      if (response.error != null) {
        showSnackbar(
          title: AppConst.login.loginFailedTitle,
          message: response.error!,
          type: SnackbarType.error,
        );
        return;
      }

      if (response.user != null) {
        // 保存用户信息到本地存储
        await StorageManager.setData(
            AppConst.identifier.userInfo, response.user!.toJson());

        // 设置登录状态
        _globalController.setIsLogin(true);

        showSnackbar(
          title: AppConst.login.loginSuccessTitle,
          message: '${AppConst.login.welcomeBack}${response.user!.username}',
          type: SnackbarType.success,
        );

        // 延迟跳转，让用户看到成功提示
        await Future.delayed(const Duration(milliseconds: 1500));
        Get.offAllNamed(Routes.HOME);
      } else {
        showSnackbar(
          title: AppConst.login.loginFailedTitle,
          message: AppConst.login.userInfoError,
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      l.e('登录失败: $e');
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
