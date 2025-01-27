import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 跳转到设置页面
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 用户信息卡片
          _buildUserCard(context),
          SizedBox(height: 16.w),
          // 功能列表
          _buildFunctionList(context),
        ],
      ),
    );
  }

  // 用户信息卡片
  Widget _buildUserCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 头像
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).dividerColor.withValues(alpha: .1),
            ),
            child: Icon(
              Icons.person_outline,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(width: 16.w),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '用户名',
                  style: TextStyle(
                    fontSize: 18.w,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  '这个人很懒，什么都没有写...',
                  style: TextStyle(
                    fontSize: 14.w,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          // 编辑按钮
          IconButton(
            icon: Icon(Icons.edit,
                color:
                    Theme.of(context).iconTheme.color?.withValues(alpha: .5)),
            onPressed: () {
              // TODO: 编辑个人信息
            },
          ),
        ],
      ),
    );
  }

  // 功能列表
  Widget _buildFunctionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFunctionItem(context, '我的收藏', Icons.favorite_border, () {}),
          _buildFunctionItem(context, '浏览历史', Icons.history, () {}),
          _buildFunctionItem(context, '我的评论', Icons.comment_outlined, () {}),
          _buildFunctionItem(context, '我的点赞', Icons.thumb_up_outlined, () {}),
          _buildFunctionItem(context, '消息通知', Icons.notifications_none, () {}),
          _buildFunctionItem(context, '帮助反馈', Icons.help_outline, () {}),
          _buildFunctionItem(context, '退出登录', Icons.info_outline, () {
            // 先做个临时处理
            controller.logout();
          }),
        ],
      ),
    );
  }

  // 功能列表项
  Widget _buildFunctionItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.w,
              color: Theme.of(context).iconTheme.color,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.w,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20.w,
              color: Theme.of(context).iconTheme.color?.withValues(alpha: .5),
            ),
          ],
        ),
      ),
    );
  }
}
