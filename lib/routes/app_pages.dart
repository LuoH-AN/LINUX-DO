import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_controller.dart';
import '../pages/startup/startup_controller.dart';
import '../pages/startup/startup_page.dart';
import '../pages/home/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
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
      binding: HomeBinding(),
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
