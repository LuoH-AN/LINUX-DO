import 'package:get/get.dart';
import '../../controller/base_controller.dart';

class LoginController extends BaseController {
  final username = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (username.value.isEmpty) {
      showError('请输入用户名');
      return;
    }
    if (password.value.isEmpty) {
      showError('请输入密码');
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      Get.offAllNamed('/home');
    } catch (e) {
      isLoading.value = false;
      showError(e.toString());
    }
  }
} 