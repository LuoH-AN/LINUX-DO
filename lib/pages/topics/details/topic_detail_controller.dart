import 'package:get/get.dart';
import 'package:linux_do/const/app_const.dart';
import 'package:linux_do/controller/base_controller.dart';
import '../../../models/topic_detail.dart';
import '../../../net/api_service.dart';
import '../../../utils/log.dart';
import '../../../widgets/state_view.dart';

class TopicDetailController extends BaseController {
  final ApiService _apiService = Get.find<ApiService>();

  final topicDetail = Rxn<TopicDetail>();

  late final int topicId;

  @override
  void onInit() {
    super.onInit();
    final id = Get.arguments;
    if (id != null && id is int) {
      topicId = id;
      fetchTopicDetail();
    } else {
      hasError.value = true;
      errorMessage.value = '帖子ID不能为空';
    }
  }

  Future<void> fetchTopicDetail() async {
    l.d('获取帖子详情: $topicId');
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await _apiService.getTopicDetail(
        topicId.toString(),
        trackVisit: true,
        forceLoad: true,
      );
      topicDetail.value = response;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = AppConst.stateHint.error;
      l.e('获取帖子详情失败: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshTopicDetail() async {
    await fetchTopicDetail();
  }

  ViewState getViewState() {
    if (isLoading.value) {
      return ViewState.loading;
    }
    if (hasError.value) {
      return ViewState.error;
    }
    return ViewState.content;
  }
}
