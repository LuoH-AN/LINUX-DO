import 'package:get/get.dart';

import '../../controller/base_controller.dart';
import '../../models/post.dart';
import '../../net/api_service.dart';

class HomeController extends BaseController {
  // 当前选中的tab索引
  final RxInt currentTab = 0.obs;

  // 帖子列表数据
  final RxList<Post> posts = <Post>[].obs;

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

    await handleAsync(() async {
      final response = await ApiService.getPosts(
        page: _page,
        limit: 10,
      );

      if (response.isSuccess) {
        final newPosts = response.data ?? [];
        posts.addAll(newPosts);
        hasMore.value = newPosts.length >= 10;
        _page++;
      } else {
        showErrorToast(response.message ?? '获取帖子列表失败');
      }
    });
  }

  // 刷新数据
  Future<void> onRefresh() async {
    _page = 1;
    hasMore.value = true;
    posts.clear();
    await fetchPosts();
  }

  // 创建帖子
  Future<void> createPost(String title, String content) async {
    await handleAsync(() async {
      final response = await ApiService.createPost(
        title: title,
        content: content,
      );

      if (response.isSuccess) {
        showSuccessToast('发布成功');
        Get.back(); // 返回列表页
        onRefresh(); // 刷新列表
      } else {
        showErrorToast(response.message ?? '发布失败');
      }
    });
  }

  // 删除帖子
  Future<void> deletePost(String id) async {
    await handleAsync(() async {
      final response = await ApiService.deletePost(id);

      if (response.isSuccess) {
        showSuccessToast('删除成功');
        posts.removeWhere((post) => post.id == id);
      } else {
        showErrorToast(response.message ?? '删除失败');
      }
    });
  }
}
