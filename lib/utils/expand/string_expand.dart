extension StringExpand on String {
  /// 判断字符串是否为空白
  bool get isNullOrBlank => trim().isEmpty;

  /// 判断字符串是否不为空白
  bool get isNotNullOrBlank => !isNullOrBlank;

  /// 转换为int类型
  int? toInt() => int.tryParse(this);

  /// 转换为double类型
  double? toDouble() => double.tryParse(this);

  /// 是否是手机号
  bool get isPhoneNumber => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);

  /// 是否是邮箱
  bool get isEmail =>
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(this);

  /// 是否是URL
  bool get isUrl =>
      RegExp(r'^https?:\/\/([\w-]+\.)+[\w-]+(\/[\w-./?%&=]*)?$').hasMatch(this);
}
