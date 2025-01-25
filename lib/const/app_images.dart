import 'package:flutter/material.dart';

class AppImages {
  // 基础路径
  static const String _lightPath = 'assets/images/light';
  static const String _darkPath = 'assets/images/dark';
  
  // 图片名称
  static const String _logoName = 'logo.webp';
  static const String _bannerName = 'search-banner.png';


  // 状态Icon
  static const String _netErrorName = 'state-net-error.png';
  static const String _empty = 'state-empty.png';

  // ICON 72x72 48x48 96x96 144x144 192x192
  static const String logoSmall =
      'https://linux.do/uploads/default/optimized/3X/9/d/9dd49731091ce8656e94433a26a3ef36062b3994_2_32x32.png';

  // 根据主题获取对应的图片路径
  static String getImagePath(BuildContext context, String imageName) {
    final basePath = Theme.of(context).brightness == Brightness.dark ? _darkPath : _lightPath;
    return '$basePath/$imageName';
  }

  // 获取logo
  static String getLogo(BuildContext context) {
    return getImagePath(context, _logoName);
  }

  // 获取banner
  static String getBanner(BuildContext context) {
    return getImagePath(context, _bannerName);
  }

    // 获取空状态
  static String getEmpty(BuildContext context) {
    return getImagePath(context, _empty);
  }

    // 网络错误
  static String getNetError(BuildContext context) {
    return getImagePath(context, _netErrorName);
  }
}
