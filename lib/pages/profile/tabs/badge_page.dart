import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linux_do/const/app_spacing.dart';
import 'package:linux_do/const/app_theme.dart';
import 'package:linux_do/models/badge_detail.dart';
import 'package:linux_do/widgets/cached_image.dart';
import 'package:linux_do/widgets/state_view.dart';
import 'package:slide_switcher/slide_switcher.dart';
import '../../../const/app_colors.dart';
import 'badge_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:linux_do/utils/badge.dart';

class BadgePage extends GetView<BadgeController> {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final viewState = controller.getViewState();
      return StateView(
        state: viewState,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.w),
          itemCount: controller.badgeGroupings.length,
          itemBuilder: (context, index) {
            final grouping = controller.badgeGroupings[index];
            return Obx(() {
              final groupBadges = controller.getFilteredBadges(grouping.id);
              if (groupBadges.isEmpty) return const SizedBox();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index == 0
                      ? Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 12.w),
                              child: Text(
                                grouping.getDisplayName(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.only(bottom: 12.w),
                              width: 100.w,
                              child: SlideSwitcher(
                                containerHeight: 20.w,
                                containerWight: 100.w,
                                initialIndex: controller.selectedIndex.value,
                                containerColor: AppColors.transparent,
                                containerBorder: Border.all(
                                    color: AppColors.primary, width: .4.w),
                                slidersColors: [Theme.of(context).cardColor],
                                isAllContainerTap: true,
                                onSelect: (index) =>
                                    controller.switchBadgeType(index),
                                children: [
                                  Text(
                                    '全部',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: controller.selectedIndex.value == 0
                                            ? AppColors.primary
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color),
                                  ),
                                  Text(
                                    '已获得',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: controller.selectedIndex.value == 1
                                            ? AppColors.primary
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.only(bottom: 12.w),
                          child: Text(
                            grouping.getDisplayName(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.w),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .shadowColor
                              .withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.w,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 1.8,
                      ),
                      itemCount: groupBadges.length,
                      itemBuilder: (context, index) {
                        final badge = groupBadges[index];
                        return _BadgeCard(badge: badge);
                      },
                    ),
                  ),
                  12.vGap,
                ],
              );
            });
          },
        ),
      );
    });
  }
}

class _BadgeCard extends GetView<BadgeController> {
  final BadgeDetail badge;

  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    final badgeColor = BadgeIconHelper.getColor(badge.name);
    return GestureDetector(
      onTap: () => _showBadgeDetail(context, badgeColor),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: badge.hasBadge
                ? [
                    badgeColor,
                    badgeColor.withValues(alpha: 0.5),
                  ]
                : [
                    badgeColor.withValues(alpha: 0.01),
                    badgeColor.withValues(alpha: 0.01),
                  ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.w),
            topRight: Radius.circular(46.w),
            bottomLeft: Radius.circular(12.w),
            bottomRight: Radius.circular(12.w),
          ),
          boxShadow: [
            BoxShadow(
              color: badgeColor.withValues(alpha: .2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 图标或图片
            if (badge.getImageUrl().isNotEmpty)
              Positioned(
                  right: 10.w,
                  bottom: 10.w,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: CachedImage(
                        imageUrl: badge.getImageUrl(),
                        width: 24.w,
                        height: 24.w,
                        circle: true,
                      ),
                    ),
                  ))
            else
              Positioned(
                right: 10.w,
                bottom: 10.w,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    BadgeIconHelper.getIcon(badge.name),
                    size: 18.w,
                    color: Colors.white,
                  ),
                ),
              ),

            // 右下角装饰图案
            // Positioned(
            //   right: -30.w,
            //   bottom: -20.w,
            //   child: Container(
            //     width: 90.w,
            //     height: 90.w,
            //     decoration: BoxDecoration(
            //       color: Colors.white.withValues(alpha: 0.1),
            //       borderRadius: BorderRadius.circular(60.w),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    badge.name,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  2.vGap,
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          height: 32.w,
                          child: Html(
                            data: badge.description,
                            style: {
                              "body": Style(
                                fontSize: FontSize(8.sp),
                                fontFamily: AppFontFamily.dinPro,
                                color: Colors.white.withValues(alpha: 0.8),
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              "p": Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                              ),
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  4.vGap,
                  Row(
                    children: [
                      Flexible(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.4.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.w),
                              color: AppColors.white.withValues(alpha: .5),
                            ),
                            child: Text(
                              controller.getBadgeTypeName(badge.badgeTypeId),
                              style: TextStyle(
                                fontFamily: AppFontFamily.dinPro,
                                fontSize: 11.sp,
                                color: badge.hasBadge
                                    ? badgeColor
                                    : badgeColor.withValues(alpha: 0.4),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          4.vGap,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.w),
                            ),
                            child: Text(
                              '已授予 ${_formatNumber(badge.grantCount)} 个',
                              style: TextStyle(
                                fontFamily: AppFontFamily.dinPro,
                                fontSize: 9.sp,
                                color: badge.hasBadge
                                    ? badgeColor
                                    : badgeColor.withValues(alpha: 0.4),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )),
                      8.hGap,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBadgeDetail(BuildContext context, Color badgeColor) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 0.8.sw,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16.w),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部渐变背景区域
              Container(
                height: 120.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        badgeColor,
                        badgeColor.withValues(alpha: 0.6),
                      ]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.w),
                    topRight: Radius.circular(16.w),
                  ),
                ),
                child: Stack(
                  children: [
                    // 关闭按钮
                    Positioned(
                      right: 16.w,
                      top: 16.w,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24.w,
                        ),
                      ),
                    ),
                    // 徽章图标
                    Center(
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: badge.getImageUrl().isNotEmpty
                            ? CachedImage(
                                imageUrl: badge.getImageUrl(),
                                width: 40.w,
                                height: 40.w,
                                circle: true,
                              )
                            : Icon(
                                BadgeIconHelper.getIcon(badge.name),
                                size: 30.w,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              // 徽章信息
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      badge.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    8.vGap,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.w,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Text(
                        badge.hasBadge ? '已获得' : '未获得',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: badgeColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    12.vGap,
                    Html(
                      data: badge.description,
                      style: {
                        "body": Style(
                          fontSize: FontSize(14.sp),
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          textAlign: TextAlign.center,
                          margin: Margins.zero,
                          padding: HtmlPaddings.zero,
                        ),
                      },
                    ),
                    if (badge.longDescription != null &&
                        badge.longDescription!.isNotEmpty) ...[
                      8.vGap,
                      Html(
                        data: badge.longDescription!,
                        style: {
                          "body": Style(
                            fontSize: FontSize(12.sp),
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            textAlign: TextAlign.center,
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                        },
                      ),
                    ],
                    16.vGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.w),
                            border: Border.all(
                              color: badgeColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            controller.getBadgeTypeName(badge.badgeTypeId),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: badgeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        12.hGap,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16.w),
                            border: Border.all(
                              color: badgeColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            '已授予 ${_formatNumber(badge.grantCount)} 个',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: badgeColor,
                              fontWeight: FontWeight.w500,
                            ),
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
      ),
      barrierDismissible: true,
    );
  }

  // 添加数字格式化方法
  String _formatNumber(int number) {
    if (number >= 1000) {
      double value = number / 1000;
      return '${value.toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
