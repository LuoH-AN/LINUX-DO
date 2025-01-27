import 'package:get/get.dart';
import 'package:linux_do/controller/base_controller.dart';

import '../../utils/mixins/toast_mixin.dart';

class LoginController extends BaseController {
  final username = ''.obs;
  final password = ''.obs;
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() {
    if (username.value.isEmpty) {
      showSnackbar(title: '提示',  message:'请输入账号',type: SnackbarType.error);
      return;
    }
    if (password.value.isEmpty) {
      showSnackbar(title: '提示',  message:'请输入密码',type: SnackbarType.error);
      return;
    }
    showSnackbar(title: '登录', message: '去登录', type: SnackbarType.success);
  }

  void forgetPassword(){
    showSnackbar(title: '未开发提示', message: '此功能暂未开发', type: SnackbarType.warning);
  }

  void reigster(){
    showSnackbar(title: '注册提示', message: '请先前往https://linux.do站点注册', type: SnackbarType.info);
  }
} 