import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/base_controller.dart';
import '../../models/topic_model.dart';
import '../../utils/log.dart';
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

  // 加载状态
  @override
  final RxBool isLoading = false.obs;

  final isRefreshing = false.obs;

  final scrollController = ScrollController();
  final isBottomBarVisible = true.obs;
  var lastScrollPosition = 0.0;

  // Tab控制器
  late TabController tabController;

  // 各个标签页的控制器
  final _tabControllers = <String, TopicTabController>{}.obs;
  final tabViews = <TopicTabView>[].obs;

  TopicsController() {
    try {
      _initTabViews();
    } catch (e) {
      l.e('初始化失败: $e');
      rethrow;
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabChange);
    _setupScrollController();
    // 初始化所有tab的controller
    for (final path in paths) {
      _initTabController(path);
    }
  }

  void _initTabViews() {
    // 只创建TabView,不初始化controller
    for (final path in paths) {
      tabViews.add(TopicTabView(path: path));
    }
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

  void _setupScrollController() {
    scrollController.addListener(() {
      final currentPosition = scrollController.position.pixels;
      // 判断滚动方向和距离
      if ((currentPosition - lastScrollPosition).abs() > 50) {
        if (currentPosition > lastScrollPosition && isBottomBarVisible.value) {
          // 向上滚动，隐藏底部栏
          isBottomBarVisible.value = false;
        } else if (currentPosition < lastScrollPosition &&
            !isBottomBarVisible.value) {
          // 向下滚动，显示底部栏
          isBottomBarVisible.value = true;
        }
        lastScrollPosition = currentPosition;
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
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
