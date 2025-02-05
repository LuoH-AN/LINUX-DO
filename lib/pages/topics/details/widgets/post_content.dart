import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linux_do/const/app_spacing.dart';
import 'package:linux_do/models/topic_detail.dart';
import 'package:linux_do/utils/log.dart';
import 'package:linux_do/widgets/html_widget.dart';

import '../topic_detail_controller.dart';

/// 帖子内容组件
class PostContent extends StatelessWidget {
  const PostContent({
    required this.node,
    Key? key,
  }) : super(key: key);

  final PostNode node;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (node.post.replyToPostNumber != null)
                    _ReplyQuote(post: node.post),
                  _PostBody(post: node.post),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 回复引用组件
class _ReplyQuote extends StatelessWidget {
  const _ReplyQuote({
    required this.post,
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TopicDetailController>();
    
    return Container(
      margin: EdgeInsets.only(bottom: 8.w),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor.withValues(alpha:  0.1),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: Row(
        children: [
          Icon(Icons.reply,
              size: 16.sp,
              color: Theme.of(context).hintColor),
          4.hGap,
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '回复 #${post.replyToPostNumber} ',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                TextSpan(
                  text: () {
                    final replyToPost = controller.topic.value?.postStream?.posts?.firstWhere(
                      (p) => p.postNumber == post.replyToPostNumber,
                      orElse: () => post,
                    );
                    return '(${replyToPost?.name?.isNotEmpty == true ? replyToPost?.name : replyToPost?.username ?? "未知用户"})';
                  }(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Theme.of(context).primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      final replyToPost = controller.topic.value?.postStream?.posts?.firstWhere(
                        (p) => p.postNumber == post.replyToPostNumber,
                        orElse: () => post,
                      );
                      l.d('点击了回复的用户名 : ${replyToPost?.name?.isNotEmpty == true ? replyToPost?.name : replyToPost?.username ?? "未知用户"}');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 帖子主体内容组件
class _PostBody extends StatelessWidget {
  final controller = Get.find<TopicDetailController>();
  _PostBody({
    required this.post,
    Key? key,
  }) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      html:post.cooked ?? '',
      onLinkTap: (url) {
        controller.launchUrl(url);
      },
    );
  }
} 