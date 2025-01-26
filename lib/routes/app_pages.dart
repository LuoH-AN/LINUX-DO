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

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.STARTUP;
  static const REGISTER = '/register';
  static const TOPIC_DETAIL = '/topic_detail';
  static const CREATE_TOPIC = '/create_topic';
  static const SEARCH = '/search';

  static final routes = <GetPage>[
    GetPage(
      name: Routes.STARTUP,
      page: () => const StartupPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<StartupController>(() => StartupController());
      }),
    ),
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
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<LoginController>(() => LoginController());
      }),
    ),
  ];
}
