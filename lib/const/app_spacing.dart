import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 间距扩展
extension SpacingX on num {
  Widget get hGap => SizedBox(width: w.toDouble());
  Widget get vGap => SizedBox(height: h.toDouble());
  
  EdgeInsets get all => EdgeInsets.all(w.toDouble());
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: w.toDouble());
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: h.toDouble());
  EdgeInsets get left => EdgeInsets.only(left: w.toDouble());
  EdgeInsets get right => EdgeInsets.only(right: w.toDouble());
  EdgeInsets get top => EdgeInsets.only(top: h.toDouble());
  EdgeInsets get bottom => EdgeInsets.only(bottom: h.toDouble());
}

/// 统一间距管理
class Spacing {
  const Spacing._();
  
  // 基础间距
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;
  
  // 常用边距
  static EdgeInsets get padding => EdgeInsets.all(md);
  static EdgeInsets get paddingH => EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets get paddingV => EdgeInsets.symmetric(vertical: md);
  static EdgeInsets get paddingSm => EdgeInsets.all(sm);
  static EdgeInsets get paddingLg => EdgeInsets.all(lg);
  
  // 水平间距
  static Widget get h4 => xs.hGap;
  static Widget get h8 => sm.hGap;
  static Widget get h16 => md.hGap;
  static Widget get h24 => lg.hGap;
  static Widget get h32 => xl.hGap;
  
  // 垂直间距
  static Widget get v4 => xs.vGap;
  static Widget get v8 => sm.vGap;
  static Widget get v16 => md.vGap;
  static Widget get v24 => lg.vGap;
  static Widget get v32 => xl.vGap;
}