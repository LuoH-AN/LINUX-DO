import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../const/app_colors.dart';
import '../const/app_const.dart';
import '../const/app_sizes.dart';
import '../const/app_spacing.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // 屏幕宽度
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: screenWidth * 0.52,
      child: Column(
        children: [
          // 头部区域
          _buildHeader(context),
          // 分割线
          Divider(color: Theme.of(context).dividerColor),
          // 主要内容区域
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 外部链接
                  _buildSection(
                    context: context,
                    title: AppConst.drawerMenu.externalLinks,
                    items: [
                      const _MenuItem(icon: Icons.visibility, title: 'Status'),
                      const _MenuItem(icon: Icons.link, title: 'Connect'),
                      const _MenuItem(icon: Icons.telegram, title: 'Telegram'),
                    ],
                  ),
                  // 类别
                  _buildSection(
                    context: context,
                    title: AppConst.drawerMenu.categories,
                    items: [
                      _MenuItem(icon: Icons.code, title: AppConst.drawerMenu.devOptimization, hasNew: false),
                      _MenuItem(icon: Icons.folder_shared, title: AppConst.drawerMenu.docBuilding, hasNew: false),
                      _MenuItem(icon: Icons.category, title: AppConst.drawerMenu.notMine, hasNew: false),
                      _MenuItem(icon: Icons.rocket_launch, title: AppConst.drawerMenu.sailAway),
                      _MenuItem(icon: Icons.card_giftcard, title: AppConst.drawerMenu.benefits, hasNew: false),
                      _MenuItem(icon: Icons.feedback, title: AppConst.drawerMenu.operationFeedback, hasNew: false),
                      _MenuItem(icon: Icons.apps, title: AppConst.drawerMenu.resources, hasNew: false),
                      _MenuItem(icon: Icons.shopping_cart, title: AppConst.drawerMenu.fleaMarket, hasNew: false),
                      _MenuItem(icon: Icons.book, title: AppConst.drawerMenu.readingPoetry, hasNew: false),
                      _MenuItem(icon: Icons.newspaper, title: AppConst.drawerMenu.frontierNews, hasNew: false),
                      _MenuItem(icon: Icons.eco, title: AppConst.drawerMenu.pickAndChoose, hasNew: false),
                      _MenuItem(icon: Icons.security, title: AppConst.drawerMenu.deepSea, hasNew: false),
                    ],
                    showViewAll: true,
                  ),
                  // 标签
                  _buildSection(
                    context: context,
                    title: AppConst.drawerMenu.tags,
                    items: [
                      _MenuItem(icon: Icons.card_giftcard, title: AppConst.drawerMenu.lottery, hasNew: false),
                      _MenuItem(icon: Icons.thumb_up, title: AppConst.drawerMenu.essentialPosts, hasNew: false),
                      _MenuItem(icon: Icons.psychology, title: AppConst.drawerMenu.ai, hasNew: false),
                      _MenuItem(icon: Icons.campaign, title: AppConst.drawerMenu.announcements, hasNew: false),
                      _MenuItem(icon: Icons.question_answer, title: AppConst.drawerMenu.qa, hasNew: false),
                    ],
                    showViewAll: true,
                  ),
                  // 消息
                  _buildSection(
                    context: context,
                    title: AppConst.drawerMenu.messages,
                    items: [
                      _MenuItem(icon: Icons.inbox, title: AppConst.drawerMenu.inbox),
                    ],
                  ),
                  // 频道
                  _buildSection(
                    context: context,
                    title: AppConst.drawerMenu.channels,
                    items: [
                      _MenuItem(icon: Icons.chat, title: AppConst.drawerMenu.regularChannel, hasNew: false),
                    ],
                    showViewAll: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + Spacing.md,
        left: Spacing.md,
        right: Spacing.md,
        bottom: Spacing.md,
      ),
      child: Row(
        children: [
          // 话题
          _buildHeaderItem(
            context: context,
            icon: Icons.layers,
            title: AppConst.drawerMenu.topics,
            hasNew: false,
          ),
          6.hGap,
          // 我的草稿
          _buildHeaderItem(
            context: context,
            icon: Icons.edit_note,
            title: AppConst.drawerMenu.myDrafts,
            hasNew: false,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool hasNew = false,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Spacing.sm),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Spacing.sc4),
        ),
        child: Row(
          children: [
            Icon(icon, size: AppSizes.iconSmall),
           14.hGap,
            Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.fontNormal,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (hasNew) ...[
             8.hGap,
              Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<_MenuItem> items,
    bool showViewAll = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题行
        Padding(
          padding: EdgeInsets.all(Spacing.sm),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.fontNormal,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              if (showViewAll) ...[
                const Spacer(),
                Icon(
                  Icons.edit,
                  size: AppSizes.iconSmall,
                  color: AppColors.primary,
                ),
              ],
            ],
          ),
        ),
        // 菜单项
        ...items.map((item) => _buildMenuItem(context, item)),

        // 分割线
        Divider(color: Theme.of(context).dividerColor),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    return InkWell(
      onTap: () {
        Get.back(); // 关闭抽屉
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              size: AppSizes.iconSmall,
              color: Theme.of(context).iconTheme.color,
            ),
            Spacing.md.hGap,
            Text(
              item.title,
              style: TextStyle(
                fontSize: AppSizes.fontNormal,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            if (item.hasNew) ...[
             8.hGap,
              Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final bool hasNew;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.hasNew = false,
  });
} 