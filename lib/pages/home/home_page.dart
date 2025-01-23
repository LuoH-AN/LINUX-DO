import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../models/topic_model.dart';
import 'home_controller.dart';
import '../../const/app_colors.dart';
import '../../const/app_icons.dart';
import '../../const/app_images.dart';
import '../base_page.dart';
import '../../utils/expand/datetime_expand.dart';

class HomePage extends BasePage<HomeController> {
  const HomePage({super.key});

  @override
  bool showAppBar() => false;

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 顶部图片
          SliverAppBar(
            expandedHeight: 160.w,
            pinned: true,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.asset(
                    AppImages.banner,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 20.w,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 36.w,
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(18.w),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey, size: 18.w),
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
                  )
                ],
              ),
              // 搜索框和标签栏在折叠时显示
              title: LayoutBuilder(
                builder: (context, constraints) {
                  final settings = context.dependOnInheritedWidgetOfExactType<
                      FlexibleSpaceBarSettings>();
                  final deltaExtent = settings!.maxExtent - settings.minExtent;
                  final t = (1.0 -
                          (settings.currentExtent - settings.minExtent) /
                              deltaExtent)
                      .clamp(0.0, 1.0);

                  return Opacity(
                    opacity: t,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 36.w,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // 标语
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12.w),
              color: AppColors.primary,
              child: Text(
                '真诚、友善、团结、专业，共建你我引以为荣之社区。《常见问题解答》',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.w,
                ),
              ),
            ),
          ),

          // 标签栏
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              minHeight: 48.w,
              maxHeight: 48.w,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Obx(() => Row(
                        children: [
                          _buildTab('最新', 0),
                          _buildTab('新 (174)', 1),
                          _buildTab('未读', 2),
                          _buildTab('热门', 3),
                          _buildTab('类别', 4),
                          _buildTab('我的帖子', 5),
                          _buildTab('书签', 6),
                        ],
                      )),
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
      floatingActionButton: Transform.translate(
        offset: Offset(30.w, 0),
        child: FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(Icons.add, color: Colors.white),
          label: Text('', style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = controller.currentTab.value == index;
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: () => controller.switchTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.w),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 2.w,
              ),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppColors.primary : Colors.grey,
              fontSize: 14.w,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
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
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8.w),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左侧头像
                  // Container(
                  //   width: 36.w,
                  //   height: 36.w,
                  //   margin: EdgeInsets.only(right: 12.w),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     image: DecorationImage(
                  //       image: NetworkImage('https://via.placeholder.com/36'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  // 右侧内容
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
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: .1),
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
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                                  decoration: BoxDecoration(
                                    color: tagColors.backgroundColor.withValues(alpha: .1),
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
                                '搞七搞三',
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
                                DateTime.parse(topic.bumpedAt ?? topic.lastPostedAt ?? topic.createdAt ?? DateTime.now().toIso8601String())
                                    .friendlyDateTime,
                                style: TextStyle(
                                  fontSize: 12.w,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.reply_rounded, 
                                    size: 14.w, 
                                    color: Colors.grey[400]
                                  ),
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

// 添加 SliverPersistentHeaderDelegate 实现
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
