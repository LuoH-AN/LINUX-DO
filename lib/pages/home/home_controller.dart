import 'package:get/get.dart';

import '../../controller/base_controller.dart';

class HomeController extends BaseController {
  // 当前选中的tab索引
  final RxInt currentTab = 0.obs;

  // 帖子列表数据
  final RxList posts = [].obs;

  // 加载状态
  final RxBool isLoading = false.obs;

  // 是否还有更多数据
  final RxBool hasMore = true.obs;

  // 当前页码
  int _page = 1;

  @override
  void onInit() {
    super.onInit();
    // 初始化时加载数据
    fetchPosts();
  }

  // 切换tab
  void switchTab(int index) {
    currentTab.value = index;
    _page = 1;
    posts.clear();
    fetchPosts();
  }

  // 获取帖子列表
  Future<void> fetchPosts() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      await Future.delayed(const Duration(seconds: 1));

      // 模拟数据
      final newPosts = List.generate(
          10,
          (index) => {
                'id': '${_page * 10 + index}',
                'title': '帖子标题 ${_page * 10 + index}',
                'category': '运营反馈',
                'isAnnouncement': index == 0,
                'viewCount': 298,
                'commentCount': 23,
                'timeAgo': '2分钟',
              });

      posts.addAll(newPosts);
      hasMore.value = _page < 5;
      _page++;
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // 刷新数据
  Future<void> onRefresh() async {
    _page = 1;
    hasMore.value = true;
    posts.clear();
    await fetchPosts();
  }
}
