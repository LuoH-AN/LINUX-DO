import 'package:get/get.dart';
import '../../controller/base_controller.dart';

class ProfileController extends BaseController {
  // 用户信息
  final RxMap<String, dynamic> userInfo = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  // 获取用户信息
  Future<void> fetchUserInfo() async {
    await handleAsync(() async {
      await Future.delayed(const Duration(seconds: 1));
      userInfo.value = {
        'username': 'Linux DO',
        'avatar': 'https://example.com/avatar.png',
        'postCount': 42,
        'followingCount': 128,
        'followerCount': 256,
      };
    });
  }

  // 退出登录
  void logout() {
    Get.offAllNamed('/login');
  }
}
