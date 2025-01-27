import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../controller/base_controller.dart';
import '../../models/topic_model.dart';
import '../../routes/app_pages.dart';

class MyTopicsController extends BaseController {
  // 加载状态
  final isRefreshing = false.obs;
  final isLoadingMore = false.obs;

  // 数据
  final topics = <Topic>[].obs;
  final hasMore = true.obs;
  final currentPage = 1.obs;

  // 控制器
  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
    fetchTopics();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  // 首次加载或刷新数据
  Future<void> fetchTopics() async {
    try {
      isLoading.value = true;
      // 模拟网络请求延迟
      await Future.delayed(const Duration(seconds: 2));

      // TODO: 实际的API调用
      // final response = await _apiService.getMyTopics(page: 1);
      // topics.value = response.topics;
      // hasMore.value = response.hasMore;

      // 模拟数据
      topics.value = List.generate(10, (index) => Topic(id: index));
      hasMore.value = true;
      currentPage.value = 1;
    } catch (e) {
      showError('获取话题列表失败：$e');
    } finally {
      isLoading.value = false;
    }
  }

  // 下拉刷新
  Future<void> onRefresh() async {
    try {
      isRefreshing.value = true;
      await Future.delayed(const Duration(seconds: 2));

      // TODO: 实际的API调用
      // final response = await _apiService.getMyTopics(page: 1);
      // topics.value = response.topics;
      // hasMore.value = response.hasMore;

      // 模拟刷新数据
      topics.value = List.generate(10, (index) => Topic(id: index + 100));
      hasMore.value = true;
      currentPage.value = 1;
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
      showError('刷新失败：$e');
    } finally {
      isRefreshing.value = false;
    }
  }

  // 加载更多
  Future<void> loadMore() async {
    if (!hasMore.value) {
      refreshController.loadNoData();
      return;
    }

    try {
      isLoadingMore.value = true;
      await Future.delayed(const Duration(seconds: 2));

      // TODO: 实际的API调用
      // final response = await _apiService.getMyTopics(page: currentPage.value + 1);
      // topics.addAll(response.topics);
      // hasMore.value = response.hasMore;

      // 模拟加载更多数据
      final moreTopics =
          List.generate(10, (index) => Topic(id: index + topics.length));
      topics.addAll(moreTopics);
      currentPage.value++;

      // 模拟没有更多数据的情况
      if (currentPage.value >= 3) {
        hasMore.value = false;
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
      showError('加载更多失败：$e');
    } finally {
      isLoadingMore.value = false;
    }
  }

  // 跳转到帖子详情
  void toTopicDetail(int id) {
    Get.toNamed(Routes.TOPIC_DETAIL, arguments: id);
  }
}
