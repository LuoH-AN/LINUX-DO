import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../pages/home/home_page.dart';
import '../pages/home/home_controller.dart';
import '../pages/login/login_page.dart';
import '../pages/login/login_controller.dart';
import '../pages/startup/startup_controller.dart';
import '../pages/startup/startup_page.dart';
import '../net/api_service.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

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
        Get.lazyPut<HomeController>(() => HomeController());
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
