import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'li_do_loading.dart';

class LiDoSmartRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool enablePullDown;
  final bool enablePullUp;
  final ScrollPhysics? physics;

  const LiDoSmartRefresher({
    super.key,
    required this.controller,
    required this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.physics = const ClampingScrollPhysics(),
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      physics: physics,
      header: CustomHeader(
        builder: (context, mode) {
          if (mode == RefreshStatus.idle) {
            return const SizedBox();
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Center(child: LinuxDoRefreshLoading()),
          );
        },
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const SizedBox();
          } else if (mode == LoadStatus.loading) {
            body = LinuxDoRefreshLoading();
          } else if (mode == LoadStatus.failed) {
            body = Text(
              '加载失败，请重试',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 14.w,
              ),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = const SizedBox();
          } else {
            body = Text(
              '没有更多数据了',
              style: TextStyle(
                color: Theme.of(context).hintColor,
                fontSize: 14.w,
              ),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.w),
            child: Center(child: body),
          );
        },
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }
} 