import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linux_do/const/app_theme.dart';
import '../const/app_const.dart';
import '../utils/mixins/animation_mixin.dart';

class LinuxDoLoadingController extends GetxController
    with GetSingleTickerProviderStateMixin, AnimationMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = createRotationController(vsync: this);
    rotationAnimation = createRotationAnimation(animationController);
    scaleAnimation = createScaleAnimation(animationController);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

class LinuxDoSquareLoading extends StatelessWidget {
  final controller = Get.put(LinuxDoLoadingController());

  LinuxDoSquareLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animationController,
      builder: (_, __) {
        return Transform.rotate(
          angle: controller.rotationAnimation.value,
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: controller.scaleAnimation.value,
              child: const Text(
                AppConst.siteName,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LinuxDoRefreshController extends GetxController
    with GetSingleTickerProviderStateMixin, AnimationMixin {
  late AnimationController animationController;
  late Animation<double> rotationAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = createRotationController(vsync: this);
    rotationAnimation = createRotationAnimation(animationController);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  double getCharOffset(int index) {
    final progress = calculatePhaseOffset(animationController.value, index);
    return calculateSineOffset(progress);
  }
}

class LinuxDoRefreshLoading extends StatelessWidget {
  final controller = Get.put(LinuxDoRefreshController());

  LinuxDoRefreshLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.rotationAnimation,
      builder: (_, __) {
        return  _buildTextAnimation(context);
      },
    );
  }

  Widget _buildTextAnimation(BuildContext context) {
    final chars = AppConst.siteName.split('');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(chars.length, (index) {
        return _LinuxDoBouncingChar(
          char: chars[index],
          offset: controller.getCharOffset(index),
          color: Theme.of(context).primaryColor,
        );
      }),
    );
  }
}

class _LinuxDoBouncingChar extends StatelessWidget {
  final String char;
  final double offset;
  final Color color;

  const _LinuxDoBouncingChar({
    required this.char,
    required this.offset,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Text(
        char,
        style: TextStyle(
          fontSize: 16.w,
          color: color,
          fontFamily: AppFontFamily.dinPro,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
