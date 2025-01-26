import 'package:get/get.dart';

import '../const/app_const.dart';
import '../utils/storage_manager.dart';
import 'base_controller.dart';

/// 全局控制器

class GlobalController extends BaseController {
  final RxString _token = ''.obs;

  /// 获取token
  String get token => _token.value;

  /// 设置token
  void setToken(String value) {
    _token.value = value;
  }

  final RxBool _isLogin = false.obs;

  /// 获取是否登录
  bool get isLogin => _isLogin.value;

  /// 设置是否登录
  void setIsLogin(bool value) {
    _isLogin.value = value;
  }

  @override
  void onInit() {
    super.onInit();

    // 获取token
    setToken(StorageManager.getString(AppConst.identifier.token) ?? '');

    // 获取是否登录
    setIsLogin(token.isNotEmpty);
  }
}
