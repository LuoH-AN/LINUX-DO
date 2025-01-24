import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_const.dart';
import '../../models/topic_model.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../routes/app_pages.dart';
import 'topics_controller.dart';

class TopicsPage extends GetView<TopicsController> {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.w,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[400]),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Image.asset(
                  AppImages.logo,
                  width: 32.w,
                  height: 32.w,
                ),
              ),
            ],
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                // 计算折叠进度 (0.0 - 1.0)
                final collapsedProgress =
                    ((160.w - top) / (160.w - kToolbarHeight)).clamp(0.0, 1.0);

                return FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // 背景图片
                      Container(
                        margin: EdgeInsets.only(top: 60.w),
                        child: Image.asset(
                          AppImages.banner,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      // 展开状态的搜索框
                      Positioned(
                        bottom: 48.w,
                        left: 16.w,
                        right: 16.w,
                        child: Opacity(
                          opacity: 1 - collapsedProgress,
                          child: Container(
                            height: 36.w,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .8),
                              borderRadius: BorderRadius.circular(18.w),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search,
                                    color: Colors.grey, size: 18.w),
                                SizedBox(width: 8.w),
                                Text(
                                  '搜索话题...',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // 折叠状态的搜索图标
                  title: Opacity(
                    opacity: collapsedProgress,
                    child: Row(
                      children: [
                        SizedBox(width: 46.w),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.grey[700]),
                          onPressed: () {
                            Get.toNamed(Routes.SEARCH);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 标语
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(8.w),
              color: AppColors.primary,
              child: Text(
                AppConst.topInfo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.w,
                ),
              ),
            ),
          ),

          // 帖子列表
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final topic = controller.topics[index];
                    return _buildTopicItem(topic);
                  },
                  childCount: controller.topics.length,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildTopicItem(Topic topic) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.onTopicTap(topic),
        borderRadius: BorderRadius.circular(8.w),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 标题行
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (topic.pinned ?? false)
                              Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 2.w),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primary.withValues(alpha: .1),
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                child: Text(
                                  '置顶',
                                  style: TextStyle(
                                    fontSize: 10.w,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Text(
                                topic.title ?? '',
                                style: TextStyle(
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        // 摘要
                        if (topic.excerpt != null && topic.excerpt!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Text(
                              topic.excerpt ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.w,
                                color: Colors.grey[600],
                                height: 1.6,
                              ),
                            ),
                          ),

                        // 标签
                        if (topic.tags != null && topic.tags!.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Wrap(
                              spacing: 8.w,
                              runSpacing: 8.w,
                              children: topic.tags!.map((tag) {
                                final tagColors = controller.getTagColors(tag);
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 2.w),
                                  decoration: BoxDecoration(
                                    color: tagColors.backgroundColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4.w),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 10.w,
                                      color: tagColors.textColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                        // 底部信息
                        Padding(
                          padding: EdgeInsets.only(top: 8.w),
                          child: Row(
                            children: [
                              Text(
                                topic.lastPosterUsername ?? '',
                                style: TextStyle(
                                  fontSize: 12.w,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                width: 3.w,
                                height: 3.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                controller.getRelativeTime(topic),
                                style: TextStyle(
                                  fontSize: 12.w,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.reply_rounded,
                                      size: 14.w, color: Colors.grey[400]),
                                  SizedBox(width: 4.w),
                                  Text(
                                    '${topic.postsCount ?? 0}',
                                    style: TextStyle(
                                      fontSize: 12.w,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
