import 'package:get/get.dart';
import '../pages/custom/custom_controller.dart';
import '../pages/home/home_controller.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_controller.dart';
import '../pages/profile/profile_controller.dart';
import '../pages/startup/startup_controller.dart';
import '../pages/startup/startup_page.dart';
import '../pages/topics/my_topics_controller.dart';
import '../pages/topics/topics_controller.dart';
import '../pages/topics/details/topic_detail_page.dart';
import '../pages/topics/details/topic_detail_controller.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static const REGISTER = '/register';
  static const TOPIC_DETAIL = '/topic_detail';
  static const CREATE_TOPIC = '/create_topic';
  static const SEARCH = '/search';

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
        Get.lazyPut(() => MyTopicsController());
        Get.lazyPut(() => CustomController());
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

    /// 帖子详情页
    GetPage(
      name: Routes.TOPIC_DETAIL,
      page: () => const TopicDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TopicDetailController());
      }),
    ),
  ];
}
