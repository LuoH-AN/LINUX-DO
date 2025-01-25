import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_const.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../widgets/drawer_menu.dart';
import 'topics_controller.dart';

class TopicsPage extends GetView<TopicsController> {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logoWidth = 70.w;
    final appBarHeight = 44.w;
    final margin = 18.w;
    final menuWidth = 44.w; // 菜单按钮宽度
    final horizontalPadding = 16.w; // 水平内边距
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        drawer: const DrawerMenu(),
        body: NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: kToolbarHeight + appBarHeight, // AppBar高度 + 搜索框高度
                  maxHeight: 180.w,
                  child: Container(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        final top = constraints.biggest.height;

                        // 计算折叠进度
                        final collapsedProgress = ((180.w - top) /
                                (180.w - kToolbarHeight - appBarHeight))
                            .clamp(0.0, 1.0);

                        return Stack(
                          children: [
                            // 搜索框（固定在AppBar下方）
                            Positioned(
                              top: kToolbarHeight,
                              left: 0,
                              right: 0,
                              height: appBarHeight,
                              child: Row(
                                children: [
                                  // 左侧菜单按钮
                                  AnimatedOpacity(
                                    opacity: collapsedProgress,
                                    duration: const Duration(milliseconds: 200),
                                    child: SizedBox(
                                      width: menuWidth * collapsedProgress,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Icons.menu_rounded,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        onPressed: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                      ),
                                    ),
                                  ),
                                  // 搜索框
                                  Expanded(
                                    child: Container(
                                      height: 32.w,
                                      margin: EdgeInsets.only(
                                        top: 4.w,
                                        bottom: 4.w,
                                        left: collapsedProgress > 0
                                            ? 0
                                            : margin, // 折叠时左边距为0
                                        right: collapsedProgress > 0
                                            ? horizontalPadding
                                            : margin,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withValues(alpha: .9),
                                        borderRadius:
                                            BorderRadius.circular(18.w),
                                        border: Border.all(
                                          color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .fillColor ??
                                              Colors.transparent,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.search,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .fillColor,
                                              size: 18.w),
                                          SizedBox(width: 8.w),
                                          Text(
                                            '搜索话题...',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .fillColor,
                                              fontSize: 13.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // 右侧logo
                                  AnimatedOpacity(
                                    opacity: collapsedProgress,
                                    duration: const Duration(milliseconds: 200),
                                    child: SizedBox(
                                      width: logoWidth * collapsedProgress,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            right: horizontalPadding),
                                        child: Image.asset(
                                          AppImages.getLogo(context),
                                          width: logoWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 背景图片（只在展开状态显示）
                            if (collapsedProgress < 1)
                              Positioned(
                                top: kToolbarHeight + appBarHeight,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: margin),
                                  child: Opacity(
                                    opacity: 1 - collapsedProgress,
                                    child: Image.asset(
                                      AppImages.getBanner(context),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                pinned: true,
              ),

              // 标语
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    AppConst.slogan.replaceAll('\n', ''),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.w,
                    ),
                  ),
                ),
              ),

              // Tab栏
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  minHeight: appBarHeight,
                  maxHeight: appBarHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context)
                              .dividerColor
                              .withValues(alpha: .1),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: TabBar(
                      isScrollable: false,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: Theme.of(context).hintColor,
                      labelStyle: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 14.w,
                        fontWeight: FontWeight.normal,
                      ),
                      indicatorColor: AppColors.primary,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: controller.tabs,
                    ),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: controller.tabViews,
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
