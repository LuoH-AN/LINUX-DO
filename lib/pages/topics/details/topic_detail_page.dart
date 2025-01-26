import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:linux_do/const/app_colors.dart';
import 'package:linux_do/utils/expand/datetime_expand.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linux_do/widgets/state_view.dart';
import '../../../const/app_spacing.dart';
import '../../../widgets/cached_image.dart';
import 'topic_detail_controller.dart';
import '../../../models/topic_detail.dart';

class TopicDetailPage extends GetView<TopicDetailController> {
  const TopicDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.topicDetail.value?.title ?? '帖子详情')),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        return StateView(
          state: controller.getViewState(),
          errorMessage: controller.errorMessage.value,
          onRetry: controller.refreshTopicDetail,
          shimmerView: ShimmerDetails(),
          child: _contentWidget(context),
        );
      }),
    );
  }

  Widget _contentWidget(BuildContext context) {
    final topic = controller.topicDetail.value;
    if (topic == null) return Container();
    final theme = Theme.of(context);
    return ListView.builder(
      itemCount: topic.postStream?.posts?.length ?? 0,
      itemBuilder: (context, index) {
        final post = topic.postStream?.posts?[index];
        if (post == null) return const SizedBox();
        return Card(
          margin: EdgeInsets.symmetric(
            horizontal: 19.w,
            vertical: 4.h,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CachedImage(
                              imageUrl: post.getAvatarUrl(),
                              width: 40.w,
                              height: 40.w,
                              circle: !post.isWebMaster(),
                              borderRadius: BorderRadius.circular(4.w),
                              placeholder: const CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                              errorWidget: Icon(
                                Icons.account_circle,
                                size: 40.w,
                                color: theme.iconTheme.color
                                    ?.withValues(alpha: .5),
                              ),
                            ),
                          8.hGap,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.displayUsername ?? '',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: !post.isWebMaster()
                                          ? theme.textTheme.titleMedium?.color
                                          : AppColors.primary),
                                ),
                                if (post.userTitle?.isNotEmpty == true)
                                  Text(
                                    post.userTitle!,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '#${post.postNumber}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                8.vGap,
                Html(
                  data: post.cooked ?? '',
                  style: {
                    "body": Style(
                      fontSize: FontSize(14.sp),
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    "a": Style(
                      color: theme.primaryColor,
                    ),
                    "img": Style(
                      width: Width(100, Unit.percent),
                      height: Height.auto(),
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      display: Display.block,
                    ),
                    "p": Style(
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                    ),
                    "img.emoji": Style(
                      width: Width(16.sp),
                      height: Height(16.sp),
                      margin: Margins.only(left: 2.sp, right: 2.sp),
                      verticalAlign: VerticalAlign.middle,
                      display: Display.inlineBlock,
                    ),
                  },
                  extensions: [
                    TagExtension(
                      tagsToExtend: {"img"},
                      builder: (ExtensionContext context) {
                        final src = context.attributes['src'];
                        if (src == null) return const SizedBox();
                        
                        // 检查是否是表情,目前暂时用这样的方式来简单处理
                        final isEmoji = context.classes.contains('emoji');
                        final isEmojiPath = src.contains('/uploads/default/original/3X/') || 
                                          src.contains('/images/emoji/twitter/') ||
                                          src.contains('/images/emoji/apple/');
                        
                        if (isEmoji || isEmojiPath) {
                          return Image.network(
                            src,
                            width: 20.sp,
                            height: 20.sp,
                            fit: BoxFit.contain,
                          );
                        }

                        return CachedImage(
                          imageUrl: src,
                          width: double.infinity,
                          placeholder: Container(),
                          errorWidget: Icon(
                            Icons.broken_image_outlined,
                            size: 40.w,
                            color: theme.iconTheme.color?.withValues(alpha: .5),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                8.vGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getRelativeTime(post),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_outlined,
                          size: 16.sp,
                          color: theme.iconTheme.color?.withValues(alpha: .5),
                        ),
                        4.hGap,
                        Text(
                          '${post.score ?? 0}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getRelativeTime(Post post) {
    final time = post.createdAt;
    if (time == null) return '';
    return DateTime.parse(time).friendlyDateTime;
  }
}
