import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/base_controller.dart';
import '../../net/api_service.dart';
import '../../routes/app_pages.dart';
import '../topics/topics_controller.dart';

class HomeController extends BaseController {
  // ignore: unused_field
  late final ApiService _apiService;
  
  final pageController = PageController();
  late final TopicsController topicsController;

  final RxMap<int, dynamic> _badgeCount = <int, dynamic>{}.obs;

  Map<int, dynamic> get badgeCount => _badgeCount.value;

  set badgeCount(Map<int, dynamic> value) => _badgeCount.value = value;

  // 当前选中的tab索引
  final RxInt currentTab = 0.obs;


  // 加载状态
  @override
  final RxBool isLoading = false.obs;

  final isRefreshing = false.obs;

  HomeController() {
    try {
      _apiService = Get.find<ApiService>();
    } catch (e) {
      showError('ApiService not initialized');
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();

    topicsController = Get.find<TopicsController>();

    // 模拟请求的数据
    badgeCount = {
      0: '12'
    };
  }

    @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // 切换tab
  void switchTab(int index) {
    if (index == 2) {
      // 处理发帖按钮点击
      Get.toNamed(Routes.CREATE_TOPIC);
      return;
    }
    currentTab.value = index;
    if (index == 0) {
      
    }
  }
}
