import 'package:flutter/material.dart';
import 'package:linux_do/const/app_spacing.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../const/app_colors.dart';
import '../utils/log.dart';

class ImagePreviewDialog extends StatelessWidget {
  final String imageUrl;
  final String? heroTag;

  const ImagePreviewDialog({
    Key? key,
    required this.imageUrl,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 图片预览
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black87,
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(
                  imageUrl,
                  maxWidth: 2048,
                  maxHeight: 2048,
                ),
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      value: event?.expectedTotalBytes != null
                          ? event!.cumulativeBytesLoaded / event.expectedTotalBytes!
                          : null,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                errorBuilder: (context, error, stackTrace) {
                  l.e('图片加载失败: $error');
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 40.w,
                        ),
                        8.vGap,
                        Text(
                          '加载失败',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                heroAttributes: heroTag != null
                    ? PhotoViewHeroAttributes(tag: heroTag!)
                    : null,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3,
                initialScale: PhotoViewComputedScale.contained,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // 关闭按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.w,
            right: 16.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(18.w),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 显示图片预览弹窗的便捷方法
void showImagePreview(BuildContext context, String imageUrl, {String? heroTag}) {
  l.d('显示图片预览: imageUrl=$imageUrl, heroTag=$heroTag');
  showDialog(
    context: context,
    builder: (context) => ImagePreviewDialog(
      imageUrl: imageUrl,
      heroTag: heroTag,
    ),
  );
} 