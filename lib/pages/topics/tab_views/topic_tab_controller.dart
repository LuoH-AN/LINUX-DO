import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controller/base_controller.dart';
import '../../../models/topic_model.dart';
import '../../../net/api_service.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/log.dart';
import '../../../utils/user_cache.dart';

class TopicTabController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final String path;
  final ApiService apiService = Get.find();
  final _userCache = UserCache();
  late final RefreshController refreshController;
  final topics = <Topic>[].obs;
  final hasMore = true.obs;
  final currentPage = 1.obs;

  // 加载状态
  final isRefreshing = false.obs;
  final isLoadingMore = false.obs;

  TopicTabController({
    required this.path,
  }) {
    refreshController = RefreshController();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopics();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  // 获取话题列表
  Future<void> fetchTopics() async {
    try {
      isLoading.value = true;
      clearError();
      final response = await apiService.getTopics(path);

      // 更新用户缓存
      _userCache.updateUsers(response.users);

      topics.value = response.topicList?.topics ?? [];
      hasMore.value = response.topicList?.moreTopicsUrl != null;
      currentPage.value = 1;
      l.d('获取话题列表成功: ${topics.length} 条数据');
    } catch (e) {
      l.e('获取话题列表失败: $e');
      setError('获取话题列表失败');
    } finally {
      isLoading.value = false;
    }
  }

  // 刷新数据
  Future<void> onRefresh() async {
    try {
      isRefreshing.value = true;
      clearError(); // 清除之前的错误
      final response = await apiService.getTopics(path);

      // 更新用户缓存
      _userCache.updateUsers(response.users);

      topics.value = response.topicList?.topics ?? [];
      hasMore.value = response.topicList?.moreTopicsUrl != null;
      currentPage.value = 1;
      refreshController.refreshCompleted();
      l.d('刷新数据成功');
    } catch (e) {
      refreshController.refreshFailed();
      setError('刷新失败');
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
      clearError(); // 清除之前的错误
      final nextPage = currentPage.value + 1;
      final response = await apiService.getTopics('$path?page=$nextPage');

      // 更新用户缓存
      _userCache.updateUsers(response.users);

      topics.addAll(response.topicList?.topics ?? []);
      hasMore.value = response.topicList?.moreTopicsUrl != null;
      currentPage.value = nextPage;

      if (!hasMore.value) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      l.d('加载更多成功');
    } catch (e) {
      refreshController.loadFailed();
      setError('加载更多失败');
    } finally {
      isLoadingMore.value = false;
    }
  }

  // 跳转到帖子详情
  void toTopicDetail(int id) {
    l.d('当前的id: $id');
    Get.toNamed(Routes.TOPIC_DETAIL, arguments: id);
  }

  // 获取最新发帖人头像
  String? getLatestPosterAvatar(Topic topic) {
    final latestPosterId = topic.getOriginalPosterId();
    if (latestPosterId == null) return null;
    return _userCache.getAvatarUrl(latestPosterId);
  }

  // 获取昵称
  String? getNickName(Topic topic) {
    final latestPosterId = topic.getOriginalPosterId();
    if (latestPosterId == null) return null;
    return _userCache.getUserName(latestPosterId);
  }
}
