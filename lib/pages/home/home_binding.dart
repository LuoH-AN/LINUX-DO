import 'package:get/get.dart';
import 'home_controller.dart';
import '../topics/topics_controller.dart';
import '../topics/my_topics_controller.dart';
import '../custom/custom_controller.dart';
import '../profile/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => TopicsController());
    Get.lazyPut(() => MyTopicsController());
    Get.lazyPut(() => CustomController());
    Get.lazyPut(() => ProfileController());
  }
} 