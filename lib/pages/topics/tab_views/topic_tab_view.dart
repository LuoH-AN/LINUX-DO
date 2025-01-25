import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/log.dart';
import '../../../widgets/linux_do_refresh.dart';
import '../../../widgets/state_view.dart';
import '../../../widgets/topic_item.dart';
import 'topic_tab_controller.dart';

class TopicTabView extends GetView<TopicTabController> {
  final String path;

  const TopicTabView({
    super.key,
    required this.path,
  });

  @override
  String? get tag => path;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final content = LinuxDoSmartRefresher(
        controller: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.loadMore,
        enablePullDown: true,
        enablePullUp: true,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.topics.length,
          itemBuilder: (context, index) {
            final topic = controller.topics[index];
            return TopicItem(
              topic: topic,
              avatarUrl: controller.getLatestPosterAvatar(topic),
              nickName: controller.getNickName(topic),
              onTap: () => controller.onTopicTap(topic),
              onDoNotDisturb: (topic) {
                l.d('免打扰 ： ${topic.id}');
              },
            );
          },
        ),
      );

      return StateView(
        state: _getViewState(),
        errorMessage: controller.errorMessage.value,
        onRetry: controller.fetchTopics,
        child: content,
      );
    });
  }

  ViewState _getViewState() {
    if (controller.isLoading.value) {
      return ViewState.loading;
    }
    if (controller.hasError.value) {
      return ViewState.error;
    }
    if (controller.topics.isEmpty) {
      return ViewState.empty;
    }
    return ViewState.content;
  }
} 