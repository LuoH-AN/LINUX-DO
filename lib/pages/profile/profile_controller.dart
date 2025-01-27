import 'package:get/get.dart';
import '../../const/app_const.dart';
import '../../controller/base_controller.dart';
import '../../controller/global_controller.dart';
import '../../utils/log.dart';
import '../../utils/storage_manager.dart';

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
    try {
      // TODO: 从API获取用户信息
      userInfo.value = {
        'username': '用户名',
        'avatar': 'https://via.placeholder.com/60',
        'bio': '这个人很懒，什么都没有写...',
        'postCount': 0,
        'followingCount': 0,
        'followerCount': 0,
      };
    } catch (e) {
      l.e('获取用户信息失败: $e');
      showError('获取用户信息失败');
    }
  }

  // 编辑个人信息
  void editProfile() {
    // TODO: 跳转到编辑个人信息页面
  }

  // 查看我的收藏
  void viewFavorites() {
    // TODO: 跳转到我的收藏页面
  }

  // 查看浏览历史
  void viewHistory() {
    // TODO: 跳转到浏览历史页面
  }

  // 查看我的评论
  void viewComments() {
    // TODO: 跳转到我的评论页面
  }

  // 查看我的点赞
  void viewLikes() {
    // TODO: 跳转到我的点赞页面
  }

  // 查看消息通知
  void viewNotifications() {
    // TODO: 跳转到消息通知页面
  }

  // 帮助反馈
  void helpAndFeedback() {
    // TODO: 跳转到帮助反馈页面
  }

  // 关于我们
  void aboutUs() {
    // TODO: 跳转到关于我们页面
  }

  // 退出登录
  void logout() {
    Get.offAllNamed('/login');

    // 清除登录状态
    final globalController = Get.find<GlobalController>();
    StorageManager.remove(AppConst.identifier.csrfToken);
    globalController.setIsLogin(false);
  }
}
