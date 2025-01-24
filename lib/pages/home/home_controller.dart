import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/base_controller.dart';
import '../../models/topic_model.dart';
import '../../net/api_service.dart';
import '../../utils/log.dart';
import '../../routes/app_pages.dart';

class HomeController extends BaseController {
  late final ApiService _apiService;

  // 当前选中的tab索引
  final RxInt currentTab = 0.obs;

  // 帖子列表数据
  final RxList<Topic> topics = <Topic>[].obs;

  // 加载状态
  @override
  final RxBool isLoading = false.obs;

  final isRefreshing = false.obs;

  HomeController() {
    try {
      _apiService = Get.find<ApiService>();
    } catch (e) {
      l.e('ApiService not initialized');
      showError('ApiService not initialized');
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
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
      fetchTopics();
    }
  }

  // 获取话题列表
  Future<void> fetchTopics() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      final response = await _apiService.getTopics();
      topics.value = response.topicList.topics;
      l.d('获取话题列表成功: ${topics.length} 条数据');
    } catch (e) {
      l.e('获取话题列表失败: $e');
      showError('获取话题列表失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  // 刷新数据
  Future<void> onRefresh() async {
    isRefreshing.value = true;
    try {
      await fetchTopics();
    } finally {
      isRefreshing.value = false;
    }
  }

  // 获取标签颜色
  ({Color backgroundColor, Color textColor}) getTagColors(String tag) {
    switch (tag) {
      // AI相关
      case '人工智能':
      case 'ChatGPT':
      case 'OpenAI':
      case 'Claude':
      case 'Copilot':
        return (
          backgroundColor: const Color(0xFF2196F3), // 蓝色
          textColor: const Color(0xFF2196F3),
        );
      
      // 技术相关
      case '软件开发':
      case 'GitHub':
      case '算法':
      case '计算机网络':
        return (
          backgroundColor: const Color(0xFF009688), // 青色
          textColor: const Color(0xFF009688),
        );

      // 服务器相关
      case 'VPS':
      case 'Cloudflare':
      case 'Serv00':
        return (
          backgroundColor: const Color(0xFF607D8B), // 蓝灰色
          textColor: const Color(0xFF607D8B),
        );

      // 娱乐相关
      case '游戏':
      case '影视':
      case '动漫':
      case '音乐':
        return (
          backgroundColor: const Color(0xFFFF9800), // 橙色
          textColor: const Color(0xFFFF9800),
        );

      // 资源相关
      case '夸克网盘':
      case '求资源':
      case 'AFF':
        return (
          backgroundColor: const Color(0xFF795548), // 棕色
          textColor: const Color(0xFF795548),
        );

      // 生活相关
      case '职场':
      case '旅行':
      case '圆圆满满':
      case '晒年味':
        return (
          backgroundColor: const Color(0xFF8BC34A), // 浅绿色
          textColor: const Color(0xFF8BC34A),
        );

      // 特殊标签
      case '快问快答':
        return (
          backgroundColor: const Color(0xFF1976D2), // 深蓝色
          textColor: const Color(0xFF1976D2),
        );
      case '纯水':
        return (
          backgroundColor: const Color(0xFF4CAF50), // 绿色
          textColor: const Color(0xFF4CAF50),
        );
      case '病友':
        return (
          backgroundColor: const Color(0xFFF44336), // 红色
          textColor: const Color(0xFFF44336),
        );
      case '树洞':
        return (
          backgroundColor: const Color(0xFF9C27B0), // 紫色
          textColor: const Color(0xFF9C27B0),
        );
      
      // 专业领域
      case '网络安全':
        return (
          backgroundColor: const Color(0xFFE91E63), // 粉色
          textColor: const Color(0xFFE91E63),
        );
      case '金融经济':
        return (
          backgroundColor: const Color(0xFF673AB7), // 深紫色
          textColor: const Color(0xFF673AB7),
        );
      case '配置优化':
        return (
          backgroundColor: const Color(0xFF3F51B5), // 靛蓝色
          textColor: const Color(0xFF3F51B5),
        );
      
      // 活动
      case '抽奖':
        return (
          backgroundColor: const Color(0xFFFF4081), // 粉红色
          textColor: const Color(0xFFFF4081),
        );

      // 默认颜色
      default:
        return (
          backgroundColor: Colors.grey,
          textColor: Colors.grey,
        );
    }
  }
}
