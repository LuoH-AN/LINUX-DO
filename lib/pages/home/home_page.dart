import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/post.dart';
import 'home_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_sizes.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 顶部Banner
          _buildBanner(),
          // 搜索栏
          _buildSearchBar(),
          // 分类标签
          _buildTabs(),
          // 帖子列表
          Expanded(
            child: _buildPostList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 顶部Banner
  Widget _buildBanner() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.all(AppSizes.spaceNormal),
      child: TextField(
        decoration: InputDecoration(
          hintText: '搜索',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMedium,
            vertical: AppSizes.spaceSmall,
          ),
        ),
      ),
    );
  }

  // 分类标签
  Widget _buildTabs() {
    final tabs = ['最新', '新(189)', '未读(125)', '未读', '热门', '热门', '类别'];
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: AppSizes.spaceSmall),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.currentTab.value == index;
            return GestureDetector(
              onTap: () => controller.switchTab(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceMedium),
                margin: EdgeInsets.only(left: AppSizes.spaceSmall),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontSize: AppSizes.fontNormal,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  // 帖子列表
  Widget _buildPostList() {
    return Obx(() {
      if (controller.posts.isEmpty && controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: ListView.builder(
          itemCount: controller.posts.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.posts.length) {
              if (controller.hasMore.value) {
                controller.fetchPosts();
                return Container(
                  padding: EdgeInsets.all(AppSizes.spaceNormal),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
              return Container(
                padding: EdgeInsets.all(AppSizes.spaceNormal),
                alignment: Alignment.center,
                child: const Text('没有更多数据了'),
              );
            }

            final post = controller.posts[index];
            return _buildPostItem(post);
          },
        ),
      );
    });
  }

  // 帖子项
  Widget _buildPostItem(Post post) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSizes.spaceNormal,
        vertical: AppSizes.spaceSmall,
      ),
      padding: EdgeInsets.all(AppSizes.spaceNormal),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (post.isAnnouncement)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceSmall,
                    vertical: 2,
                  ),
                  margin: EdgeInsets.only(right: AppSizes.spaceSmall),
                  decoration: BoxDecoration(
                    color: AppColors.primary20,
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                  child: Text(
                    '公告',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: AppSizes.fontSmall,
                    ),
                  ),
                ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.spaceSmall,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
                child: Text(
                  post.category,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.fontSmall,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.spaceSmall),
          Text(
            post.title,
            style: TextStyle(
              fontSize: AppSizes.fontMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSizes.spaceSmall),
          Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: AppSizes.iconTiny,
                color: AppColors.textHint,
              ),
              SizedBox(width: AppSizes.spaceTiny),
              Text(
                '${post.viewCount}',
                style: TextStyle(
                  fontSize: AppSizes.fontSmall,
                  color: AppColors.textHint,
                ),
              ),
              SizedBox(width: AppSizes.spaceNormal),
              Icon(
                Icons.chat_bubble_outline,
                size: AppSizes.iconTiny,
                color: AppColors.textHint,
              ),
              SizedBox(width: AppSizes.spaceTiny),
              Text(
                '${post.commentCount}',
                style: TextStyle(
                  fontSize: AppSizes.fontSmall,
                  color: AppColors.textHint,
                ),
              ),
              const Spacer(),
              Text(
                post.timeAgo,
                style: TextStyle(
                  fontSize: AppSizes.fontSmall,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
