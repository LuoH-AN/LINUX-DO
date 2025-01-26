import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../controller/base_controller.dart';
import '../../models/topic_model.dart';
import 'tab_views/topic_tab_controller.dart';
import 'tab_views/topic_tab_view.dart';

class TopicsController extends BaseController
    with GetSingleTickerProviderStateMixin {
  // 帖子列表数据
  final RxList<Topic> topics = <Topic>[].obs;

  // 保存完整的响应数据
  final Rx<TopicListResponse?> topicListResponse = Rx<TopicListResponse?>(null);

  // 路径
  final paths = ['latest', 'new', 'unread', 'unseen', 'top', 'hot'];

  // 简单一些，本地定义tab
  final tabs = const [
    Tab(text: '最新'),
    Tab(text: '新帖'),
    Tab(text: '未读'),
    Tab(text: '未看'),
    Tab(text: '排行'),
    Tab(text: '热门')
  ];

  final isRefreshing = false.obs;

  // 底部栏显示状态
  final isBottomBarVisible = true.obs;

  // Tab控制器
  late TabController tabController;

  // 各个标签页的控制器
  final _tabControllers = <String, TopicTabController>{}.obs;

  // 移除 tabViews getter，改用 _buildTabView 方法
  Widget _buildTabView(int index) {
    final path = paths[index];
    return TopicTabView(path: path);
  }

  // 获取所有tab视图
  List<Widget> get tabViews => List.generate(
        paths.length,
        (index) => _buildTabView(index),
        growable: false,
      );

  // 处理滚动通知
  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          // 向上滚动，显示底部栏
          if (!isBottomBarVisible.value) {
            isBottomBarVisible.value = true;
          }
          break;
        case ScrollDirection.reverse:
          // 向下滚动，隐藏底部栏
          if (isBottomBarVisible.value) {
            isBottomBarVisible.value = false;
          }
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  TopicsController();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabChange);
    // 只初始化当前tab的controller
    _initTabController(paths[tabController.index]);
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging) return;
    final path = paths[tabController.index];
    _initTabController(path);
  }

  void _initTabController(String path) {
    // 如果controller已经存在，不需要重新创建
    if (_tabControllers.containsKey(path)) return;

    final controller = TopicTabController(path: path);
    _tabControllers[path] = controller;
    Get.put(controller, tag: path);
  }

  @override
  void onClose() {
    tabController.removeListener(_handleTabChange);
    tabController.dispose();
    // 清理所有controller
    for (final controller in _tabControllers.values) {
      Get.delete<TopicTabController>(tag: controller.path);
    }
    _tabControllers.clear();
    super.onClose();
  }
}
