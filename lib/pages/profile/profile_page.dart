import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_sizes.dart';
import '../base_page.dart';
import 'profile_controller.dart';

class ProfilePage extends BasePage<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  String get appBarTitle => '个人中心';

  @override
  List<Widget> buildActions() => [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => Get.toNamed('/settings'),
        ),
      ];

  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.fetchUserInfo,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildStats(),
            _buildMenuList(),
          ],
        ),
      ),
    );
  }

  // 构建头部
  Widget _buildHeader() {
    return Obx(() {
      final info = controller.userInfo;
      return Container(
        padding: EdgeInsets.all(AppSizes.spaceLarge),
        child: Column(
          children: [
            CircleAvatar(
              radius: AppSizes.avatarLarge,
              backgroundImage: NetworkImage(info['avatar'] ?? ''),
            ),
            SizedBox(height: AppSizes.spaceNormal),
            Text(
              info['username'] ?? '',
              style: TextStyle(
                fontSize: AppSizes.fontLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }

  // 构建统计信息
  Widget _buildStats() {
    return Obx(() {
      final info = controller.userInfo;
      return Container(
        padding: EdgeInsets.symmetric(vertical: AppSizes.spaceNormal),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider),
            bottom: BorderSide(color: AppColors.divider),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatItem('帖子', info['postCount']?.toString() ?? '0'),
            _buildStatItem('关注', info['followingCount']?.toString() ?? '0'),
            _buildStatItem('粉丝', info['followerCount']?.toString() ?? '0'),
          ],
        ),
      );
    });
  }

  // 构建统计项
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: AppSizes.fontLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: AppSizes.spaceTiny),
        Text(
          label,
          style: TextStyle(
            fontSize: AppSizes.fontNormal,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // 构建菜单列表
  Widget _buildMenuList() {
    final menuItems = [
      {'icon': Icons.person_outline, 'title': '个人资料'},
      {'icon': Icons.favorite_border, 'title': '我的收藏'},
      {'icon': Icons.history, 'title': '浏览历史'},
      {'icon': Icons.notifications_none, 'title': '消息通知'},
      {'icon': Icons.help_outline, 'title': '帮助与反馈'},
      {'icon': Icons.logout, 'title': '退出登录'},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          leading: Icon(
            item['icon'] as IconData,
            color: AppColors.textSecondary,
          ),
          title: Text(item['title'] as String),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textHint,
          ),
          onTap: () {
            if (item['title'] == '退出登录') {
              controller.logout();
            }
            // TODO: 处理其他菜单项点击
          },
        );
      },
    );
  }
}
