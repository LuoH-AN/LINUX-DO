import 'package:get/get.dart';
import 'package:linux_do/controller/base_controller.dart';

class LoginController extends BaseController {
  final username = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (username.value.isEmpty) {
      Get.snackbar('提示', '请输入账号');
      return;
    }
    if (password.value.isEmpty) {
      Get.snackbar('提示', '请输入密码');
      return;
    }
    Get.snackbar('登录', '去登录');
  }
} 