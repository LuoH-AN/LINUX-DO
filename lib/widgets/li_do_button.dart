import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LiDoButtonType {
  primary,   // 主要按钮
  secondary, // 次要按钮
  text,      // 文本按钮
  outline,   // 边框按钮
}

enum LiDoButtonSize {
  small,   // 小按钮
  medium,  // 中等按钮
  large,   // 大按钮
}

class LiDoButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final LiDoButtonType type;
  final LiDoButtonSize size;
  final bool loading;
  final bool block;
  final IconData? icon;
  final double? width;
  final EdgeInsetsGeometry? margin;

  const LiDoButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = LiDoButtonType.primary,
    this.size = LiDoButtonSize.medium,
    this.loading = false,
    this.block = false,
    this.icon,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // 根据size确定padding和字体大小
    _getPadding();
    final fontSize = _getFontSize();
    final height = _getHeight();
    final iconSize = _getIconSize();

    // 根据type确定颜色和样式
    final style = _getButtonStyle(theme);

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading) ...[
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(_getLoadingColor(theme)),
            ),
          ),
          SizedBox(width: 8.w),
        ] else if (icon != null) ...[
          Icon(icon, size: iconSize),
          SizedBox(width: 8.w),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    // 如果是block模式，让按钮填充父容器宽度
    if (block) {
      child = Center(child: child);
    }

    return Container(
      width: block ? double.infinity : width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: style,
        child: child,
      ),
    );
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case LiDoButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w);
      case LiDoButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w);
      case LiDoButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 20.w);
    }
  }

  double _getFontSize() {
    switch (size) {
      case LiDoButtonSize.small:
        return 12.w;
      case LiDoButtonSize.medium:
        return 14.w;
      case LiDoButtonSize.large:
        return 16.w;
    }
  }

  double _getHeight() {
    switch (size) {
      case LiDoButtonSize.small:
        return 32.w;
      case LiDoButtonSize.medium:
        return 40.w;
      case LiDoButtonSize.large:
        return 48.w;
    }
  }

  double _getIconSize() {
    switch (size) {
      case LiDoButtonSize.small:
        return 16.w;
      case LiDoButtonSize.medium:
        return 18.w;
      case LiDoButtonSize.large:
        return 20.w;
    }
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    switch (type) {
      case LiDoButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          padding: _getPadding(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        );
      case LiDoButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: theme.primaryColor.withValues(alpha: .1),
          foregroundColor: theme.primaryColor,
          padding: _getPadding(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        );
      case LiDoButtonType.text:
        return TextButton.styleFrom(
          foregroundColor: theme.primaryColor,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return theme.primaryColor.withValues(alpha: .05);
              }
              return null;
            },
          ),
        );
      case LiDoButtonType.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: theme.primaryColor,
          padding: _getPadding(),
          side: BorderSide(color: theme.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return theme.primaryColor.withValues(alpha: .05);
              }
              return null;
            },
          ),
        );
    }
  }

  Color _getLoadingColor(ThemeData theme) {
    switch (type) {
      case LiDoButtonType.primary:
        return Colors.white;
      case LiDoButtonType.secondary:
      case LiDoButtonType.text:
      case LiDoButtonType.outline:
        return theme.primaryColor;
    }
  }
} 