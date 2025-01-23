import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:linux_do/const/app_spacing.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';
import '../../const/app_const.dart';
import '../base_page.dart';
import '../../const/app_icons.dart';
import 'login_controller.dart';

class LoginPage extends BasePage<LoginController> {
  const LoginPage({super.key});

  @override
  String get appBarTitle => '欢迎回来';

  @override
  bool showBackButton() => false;

  @override
  Widget buildBody(BuildContext context) {
    // 获取屏幕高度
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Logor
          Container(
            width: double.infinity,
            height: screenHeight * 0.2,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primary80]),
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 200.w,
                  ),
                ),
                10.vGap,
                Text(
                  AppConst.slogan,
                  style: TextStyle(fontSize: 14.w, color: AppColors.white),
                )
              ],
            ),
          ),

          40.vGap,

          // 用户名输入框
          SizedBox(
            height: 56.w,
            child: TextField(
              onChanged: (value) => controller.username.value = value,
              decoration: InputDecoration(
                prefixIcon: Icon(AppIcons.username, size: 18.w),
                labelText: '电子邮件/用户名',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.w),
                  borderSide: BorderSide(width: 1.w),
                ),
              ),
            ),
          ),
          20.vGap,

          // 密码输入框
          Obx(() => SizedBox(
                height: 56.w,
                child: TextField(
                  onChanged: (value) => controller.password.value = value,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(AppIcons.password, size: 18.w),
                    labelText: '密码',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.w),
                      borderSide: BorderSide(width: 1.w),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? AppIcons.passwordVisible
                            : AppIcons.passwordInvisible,
                        size: 18.w,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),
              )),
          30.vGap,

          // 登录按钮
          SizedBox(
            width: double.infinity,
            height: 50.w,
            child: ElevatedButton.icon(
              onPressed: controller.login,
              icon: Icon(AppIcons.login, size: 20.w),
              label: Text('登录', style: TextStyle(fontSize: 16.w)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.w),
                ),
              ),
            ),
          ),

          // 其他选项（如注册链接）
          20.vGap,
          TextButton.icon(
            onPressed: () {
              // TODO: 实现注册功能
            },
            icon: Icon(AppIcons.register, size: 20.w),
            label: Text('还没有账号？立即注册', style: TextStyle(fontSize: 14.w)),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
            ),
          ),
        ],
      ),
    );
  }
}
