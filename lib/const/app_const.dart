class AppConst {
  /// L 站名称
  static const String siteName = 'LINUX DO';

  /// 我们的口号
  static const String slogan = '真诚、友善、团结、专业，\n共建你我引以为荣之社区。';

  /// 顶部信息
  static const String topInfo = '真诚、友善、团结、专业，共建你我引以为荣之社区。《常见问题解答》';

  /// 抽屉菜单
  static const drawerMenu = _DrawerMenu();

  /// 各种状态的提示
  static const stateHint = _StateConst();

  /// 标识常量
  static const identifier = _Identifier();

  /// 登录页面相关
  static const login = _LoginConst();
}

/// 抽屉菜单文本
class _DrawerMenu {
  const _DrawerMenu();

  String get topics => '话题';
  String get myDrafts => '草稿';
  String get externalLinks => '外部链接';
  String get categories => '类别';
  String get tags => '标签';
  String get messages => '消息';
  String get channels => '频道';
  String get inbox => '收件箱';
  String get regularChannel => '常规频道';

  // 类别
  String get devOptimization => '开发调优';
  String get docBuilding => '文档共建';
  String get notMine => '非我莫属';
  String get sailAway => '扬帆起航';
  String get benefits => '福利羊毛';
  String get operationFeedback => '运营反馈';
  String get resources => '资源荟萃';
  String get fleaMarket => '跳蚤市场';
  String get readingPoetry => '读书成诗';
  String get frontierNews => '前沿快讯';
  String get pickAndChoose => '摘七拾三';
  String get deepSea => '深海幽域';

  // 标签
  String get lottery => '抽奖';
  String get essentialPosts => '精华神帖';
  String get ai => '人工智能';
  String get announcements => '公告';
  String get qa => '快问快答';
}

class _StateConst {
  const _StateConst();

  String get error => '出错啦~';
  String get empty => '暂无数据哦~';
}

/// 标识常量
class _Identifier {
  const _Identifier();

  String get token => 'token';
  String get userInfo => 'userInfo';
  String get theme => 'theme';
  String get language => 'language';
  String get isFirst => 'isFirst';
  String get csrfToken => 'csrfToken';
}

/// 登录页面文本
class _LoginConst {
  const _LoginConst();

  String get title => '登录';
  String get webTitle => '使用网页授权登录';
  String get greetingPhrase => '欢迎来到';
  String get accountHint => '请输入账号';
  String get passwordHint => '请输入密码';
  String get forgotPassword => '我忘记密码了';
  String get noAccount => '还没有账号？';
  String get register => '立即注册';
  String get agreement => '登录即代表同意';
  String get serviceAgreement => '服务协议';
  String get and => '和';
  String get privacyPolicy => '隐私政策';

  // 提示信息
  String get emptyUsername => '请输入账号';
  String get emptyPassword => '请输入密码';
  String get loginFailedTitle => '登录失败';
  String get networkError => '请检查网络连接或稍后重试';
  String get userInfoError => '用户信息获取失败';
  String get loginSuccessTitle => '登录成功';
  String get welcomeBack => '欢迎回来';
  String get notImplemented => '此功能暂未开发';
  String get registerTip => '请先前往https://linux.do站点注册';
}
