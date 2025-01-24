import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'custom_controller.dart';

class CustomPage extends GetView<CustomController> {
  const CustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildSection('主题设置', [
            _buildSettingItem('深色模式', Icons.dark_mode, () {}),
            _buildSettingItem('字体大小', Icons.format_size, () {}),
            _buildSettingItem('主题颜色', Icons.color_lens, () {}),
          ]),
          SizedBox(height: 16.w),
          _buildSection('通知设置', [
            _buildSettingItem('消息通知', Icons.notifications, () {}),
            _buildSettingItem('声音', Icons.volume_up, () {}),
            _buildSettingItem('震动', Icons.vibration, () {}),
          ]),
          SizedBox(height: 16.w),
          _buildSection('其他设置', [
            _buildSettingItem('清除缓存', Icons.cleaning_services, () {}),
            _buildSettingItem('关于', Icons.info, () {}),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.w,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
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
            Icon(icon, size: 20.w, color: Colors.grey[600]),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.w,
                color: Colors.grey[800],
              ),
            ),
            Spacer(),
            Icon(Icons.chevron_right, size: 20.w, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
} 