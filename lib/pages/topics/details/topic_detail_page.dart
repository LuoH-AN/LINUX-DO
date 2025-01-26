import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'topic_detail_controller.dart';

class TopicDetailPage extends GetView<TopicDetailController> {
  const TopicDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.topicDetail.value?.title ?? '帖子详情')),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                ElevatedButton(
                  onPressed: controller.refreshTopicDetail,
                  child: const Text('重试'),
                ),
              ],
            ),
          );
        }

        final topic = controller.topicDetail.value;
        if (topic == null) {
          return const Center(child: Text('帖子不存在'));
        }

        return SmartRefresher(
          controller: RefreshController(),
          onRefresh: () async {
            await controller.refreshTopicDetail();
          },
          child: ListView.builder(
            itemCount: topic.postStream.posts.length,
            itemBuilder: (context, index) {
              final post = topic.postStream.posts[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 用户信息行
                      Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: post.avatarTemplate
                                  .replaceAll('{size}', '48'),
                              width: 40.w,
                              height: 40.w,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.displayUsername,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (post.userTitle != null)
                                  Text(
                                    post.userTitle!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Text(
                            '#${post.postNumber}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // 帖子内容
                      Html(
                        data: post.cooked,
                        style: {
                          "body": Style(
                            fontSize: FontSize(14.sp),
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                          "a": Style(
                            color: Theme.of(context).primaryColor,
                          ),
                        },
                      ),
                      // 底部信息
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post.createdAt,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_outlined, size: 16.sp),
                              SizedBox(width: 4.w),
                              Text(
                                '${post.score}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
