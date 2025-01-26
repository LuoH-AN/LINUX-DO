import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linux_do/const/app_colors.dart';
import '../../const/app_spacing.dart';
import '../../const/app_images.dart';
import '../../const/app_const.dart';
import '../../widgets/li_do_button.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    /// 屏幕高度
    final topHeight = MediaQuery.of(context).size.height * .36;
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            // 顶部背景
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                AppImages.getHeaderBackground(context),
                fit: BoxFit.fill,
              ),
            ),

            Positioned(
              top: 40.w,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Text(
                    AppConst.login.title,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // 主要内容
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  topHeight.vGap,
                  // 账号输入框
                  Container(
                    height: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.hintColor.withValues(alpha: .2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 14.sp),
                      onChanged: (value) => controller.username.value = value,
                      decoration: InputDecoration(
                        hintText: AppConst.login.accountHint,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: theme.hintColor.withValues(alpha: .2),
                        ),
                        filled: false,
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Image.asset(
                            AppImages.getInputAccount(context),
                            width: 20.w,
                            height: 20.w,
                            color: AppColors.primary,
                          ),
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                      ),
                    ),
                  ),
                  16.vGap,
                  // 密码输入框
                  Container(
                    height: 44.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.hintColor.withValues(alpha: .2),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Obx(
                      () => TextField(
                        style: TextStyle(fontSize: 14.sp),
                        onChanged: (value) => controller.password.value = value,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: AppConst.login.passwordHint,
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: theme.hintColor.withValues(alpha: .2),
                          ),
                          filled: false,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Image.asset(
                              AppImages.getInputPassword(context),
                              width: 20.w,
                              height: 20.w,
                              color: AppColors.primary,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: theme.hintColor,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
                        ),
                      ),
                    ),
                  ),
                  12.vGap,
                  // 忘记密码和注册
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppConst.login.forgotPassword,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: theme.hintColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            AppConst.login.noAccount,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: theme.hintColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AppConst.login.register,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  24.vGap,
                  // 登录按钮
                  SizedBox(
                    width: double.infinity,
                    height: 44.w,
                    child: LiDoButton(
                      text: AppConst.login.title,
                      type: LiDoButtonType.primary,
                      size: LiDoButtonSize.large,
                      onPressed: controller.login,
                      loading: true,
                    ),
                  ),
                  const Spacer(),
                  // 底部协议
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: AppConst.login.agreement,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.hintColor,
                        ),
                        children: [
                          TextSpan(
                            text: AppConst.login.serviceAgreement,
                            style: TextStyle(
                              color: theme.primaryColor,
                            ),
                          ),
                          TextSpan(text: ' ${AppConst.login.and} '),
                          TextSpan(
                            text: AppConst.login.privacyPolicy,
                            style: TextStyle(
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  20.vGap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
