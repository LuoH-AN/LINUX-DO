import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../topics/topics_page.dart';
import '../topics/my_topics_page.dart';
import '../custom/custom_page.dart';
import '../profile/profile_page.dart';
import 'home_controller.dart';
import '../../const/app_colors.dart';
import '../../const/app_icons.dart';
import '../../const/app_images.dart';
import '../base_page.dart';
import '../../utils/expand/datetime_expand.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.currentTab.value,
        children: [
          TopicsPage(), // 分类帖子
          MyTopicsPage(), // 我的帖子
          Container(), // 占位，实际不会显示
          CustomPage(), // 自定义
          ProfilePage(), // 我的
        ],
      )),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        backgroundColor: Colors.white,
        color: Colors.grey,
        activeColor: AppColors.primary,
        items: [
          TabItem(
            icon: Icons.article_outlined,
            title: '帖子',
          ),
          TabItem(
            icon: Icons.bookmark_border,
            title: '我的帖子',
          ),
          TabItem(
            icon: Icons.add,
            title: '发帖',
          ),
          TabItem(
            icon: Icons.dashboard_customize_outlined,
            title: '自定义',
          ),
          TabItem(
            icon: Icons.person_outline,
            title: '我的',
          ),
        ],
        initialActiveIndex: controller.currentTab.value,
        onTap: controller.switchTab,
        height: 50.w,
        curveSize: 100.w,
        top: -20.w,
        elevation: 0.5,
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
