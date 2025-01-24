import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../const/app_colors.dart';
import '../../const/app_sizes.dart';
import '../base_page.dart';
import 'profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // TODO: 跳转到设置页面
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          // 用户信息卡片
          _buildUserCard(),
          SizedBox(height: 16.w),
          // 功能列表
          _buildFunctionList(),
        ],
      ),
    );
  }

  // 用户信息卡片
  Widget _buildUserCard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
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
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/60'),
                fit: BoxFit.cover,
              ),
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
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  '这个人很懒，什么都没有写...',
                  style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // 编辑按钮
          IconButton(
            icon: Icon(Icons.edit, color: Colors.grey[400]),
            onPressed: () {
              // TODO: 编辑个人信息
            },
          ),
        ],
      ),
    );
  }

  // 功能列表
  Widget _buildFunctionList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFunctionItem('我的收藏', Icons.favorite_border, () {}),
          _buildFunctionItem('浏览历史', Icons.history, () {}),
          _buildFunctionItem('我的评论', Icons.comment_outlined, () {}),
          _buildFunctionItem('我的点赞', Icons.thumb_up_outlined, () {}),
          _buildFunctionItem('消息通知', Icons.notifications_none, () {}),
          _buildFunctionItem('帮助反馈', Icons.help_outline, () {}),
          _buildFunctionItem('关于我们', Icons.info_outline, () {}),
        ],
      ),
    );
  }

  // 功能列表项
  Widget _buildFunctionItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24.w, color: Colors.grey[600]),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.w,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, size: 24.w, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
