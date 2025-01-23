import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  /// 亮色主题
  static ThemeData get lightTheme {
    return ThemeData(
      // 主题色
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primary40,
      primaryColorDark: AppColors.primary,

      // 次要色
      secondaryHeaderColor: AppColors.secondary,

      // 背景色
      scaffoldBackgroundColor: AppColors.background,

      // AppBar主题
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppSizes.fontLarge,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMedium,
            vertical: AppSizes.spaceNormal,
          ),
          textStyle: TextStyle(
            fontSize: AppSizes.fontNormal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMedium,
          vertical: AppSizes.spaceNormal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),

      // 卡片主题
      cardTheme: CardTheme(
        color: AppColors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
        ),
        margin: EdgeInsets.all(AppSizes.spaceNormal),
      ),

      // 分割线主题
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 0,
      ),

      // 文字主题
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: AppSizes.fontGiant,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: AppSizes.fontHuge,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: AppSizes.fontLarge,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSizes.fontMedium,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: AppSizes.fontNormal,
          color: AppColors.textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: AppSizes.fontSmall,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  /// 暗色主题
  static ThemeData get darkTheme {
    return ThemeData(
      // 主题色
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primary40,
      primaryColorDark: AppColors.primary,

      // 次要色
      secondaryHeaderColor: const Color(0xFF334466),

      // 背景色
      scaffoldBackgroundColor: const Color(0xFF121212),

      // AppBar主题
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: AppSizes.fontLarge,
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.spaceMedium,
            vertical: AppSizes.spaceNormal,
          ),
          textStyle: TextStyle(
            fontSize: AppSizes.fontNormal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.spaceMedium,
          vertical: AppSizes.spaceNormal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: Color(0xFF404040)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: Color(0xFF404040)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: Color(0xFFCF6679)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
          borderSide: const BorderSide(color: Color(0xFFCF6679)),
        ),
        labelStyle: const TextStyle(color: Color(0xFFBBBBBB)),
        hintStyle: const TextStyle(color: Color(0xFF808080)),
      ),

      // 卡片主题
      cardTheme: CardTheme(
        color: const Color(0xFF2C2C2C),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusNormal),
        ),
        margin: EdgeInsets.all(AppSizes.spaceNormal),
      ),

      // 分割线主题
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2C2C2C),
        thickness: 0.5,
        space: 0,
      ),

      // 文字主题
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: AppSizes.fontGiant,
          color: const Color(0xFFE0E0E0),
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          fontSize: AppSizes.fontHuge,
          color: const Color(0xFFE0E0E0),
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: AppSizes.fontLarge,
          color: const Color(0xFFE0E0E0),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          fontSize: AppSizes.fontMedium,
          color: const Color(0xFFE0E0E0),
        ),
        bodyMedium: TextStyle(
          fontSize: AppSizes.fontNormal,
          color: const Color(0xFFE0E0E0),
        ),
        bodySmall: TextStyle(
          fontSize: AppSizes.fontSmall,
          color: const Color(0xFFBBBBBB),
        ),
      ),

      // 图标主题
      iconTheme: const IconThemeData(
        color: Color(0xFFE0E0E0),
      ),

      // 切换按钮主题
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return const Color(0xFF808080);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary40;
          }
          return const Color(0xFF404040);
        }),
      ),

      // 复选框主题
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return const Color(0xFF808080);
        }),
        checkColor: MaterialStateProperty.all(AppColors.white),
      ),

      // 单选按钮主题
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return const Color(0xFF808080);
        }),
      ),

      // 底部导航栏主题
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1F1F1F),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Color(0xFF808080),
      ),

      // 浮动按钮主题
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),

      brightness: Brightness.dark,
    );
  }
}
