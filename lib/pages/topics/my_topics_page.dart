import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/loading_animation.dart';
import '../../widgets/linux_do_refresh.dart';
import 'my_topics_controller.dart';
import '../../widgets/topic_item.dart';

class MyTopicsPage extends GetView<MyTopicsController> {
  const MyTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的帖子'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: LinuxDoSquareLoading());
        }

        if (controller.topics.isEmpty) {
          return Center(
            child: Text(
              '暂无数据',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 14.sp,
              ),
            ),
          );
        }

        return LinuxDoSmartRefresher(
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.loadMore,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: controller.topics.length,
            itemBuilder: (context, index) {
              final topic = controller.topics[index];
              return TopicItem(
                topic: topic,
                onTap: () {
                  // TODO: 处理点击事件
                },
              );
            },
          ),
        );
      }),
    );
  }
}
