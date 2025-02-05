import 'package:get/get.dart';
import '../pages/chat/chat_detail_controller.dart';
import '../pages/chat/chat_detail_page.dart';
import '../pages/create/create_post_controller.dart';
import '../pages/chat/chat_controller.dart';
import '../pages/topics/details/topic_detail_controller.dart';
import '../pages/topics/details/topic_detail_page.dart';
import '../pages/settings/settings_controller.dart';
import '../pages/home/home_controller.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_controller.dart';
import '../pages/profile/profile_controller.dart';
import '../pages/settings/settings_page.dart';
import '../pages/startup/startup_controller.dart';
import '../pages/startup/startup_page.dart';
import '../pages/category/category_topics_controller.dart';
import '../pages/topics/topics_controller.dart';
import '../pages/common/webview_page.dart';
import '../pages/common/webview_controller.dart';
import '../pages/create/create_post_page.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.STARTUP;
  static final routes = <GetPage>[
    /// 启动页
    GetPage(
      name: Routes.STARTUP,
      page: () => const StartupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<StartupController>(() => StartupController());
      }),
    ),

    /// 主页
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
        Get.lazyPut(() => TopicsController());
        Get.lazyPut(() => CategoryTopicsController());
        Get.lazyPut(() => ChatController());
        Get.lazyPut(() => ProfileController());
      }),
    ),

    /// 登录页
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),

    /// 设置页
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
    ),

    /// 帖子详情页
    GetPage(
      name: Routes.TOPIC_DETAIL,
      page: () => const TopicDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TopicDetailController());
      }),
    ),

    /// WebView页面
    GetPage(
      name: Routes.WEBVIEW,
      page: () => const WebViewPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => WebViewController());
      }),
    ),

    /// 创建帖子页
    GetPage(
      name: Routes.CREATE_TOPIC,
      page: () => const CreatePostPage(),
      binding: BindingsBuilder(() {
         Get.lazyPut(() => CreatePostController());
      }),
    ),

    /// 聊天详情页
    GetPage(
      name: Routes.CHAT_DETAIL,
      page: () => const ChatDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ChatDetailController());
      }),
    ),
  ];
}
