import 'package:linux_do/net/http_config.dart';
import '../models/topic_model.dart';

class UserCache {
  static final UserCache _instance = UserCache._internal();
  factory UserCache() => _instance;
  UserCache._internal();

  // 用户头像URL缓存
  final Map<int, UserData> _avatarUrls = {};
  
  // 用户信息缓存
  final Map<int, User> _users = {};

  // 清除所有缓存
  clear() {
    _avatarUrls.clear();
    _users.clear();
  }

  // 更新用户缓存
  void updateUsers(List<User>? users) {
    if (users == null) return;
    for (final user in users) {
      _users[user.id] = user;
      _avatarUrls[user.id] = UserData(
        userName: user.name != null && user.name!.isNotEmpty ? user.name! : user.username ?? '',
        avatarUrl: '${HttpConfig.baseUrl}${user.avatarTemplate!.replaceAll("{size}", "62")}',
      );
    }
  }

  // 获取用户头像URL
  String? getAvatarUrl(int userId) => _avatarUrls[userId]?.avatarUrl ?? '';

  // 获取用户名
  String? getUserName(int userId) => _avatarUrls[userId]?.userName ?? '';

  // 获取用户信息
  User? getUser(int userId) => _users[userId];

  // 获取缓存大小
  int get size => _avatarUrls.length;

  // 检查是否有缓存
  bool hasCache(int userId) => _avatarUrls.containsKey(userId);
} 

class UserData {
  final userName;
  final avatarUrl;

  UserData({
    required this.userName,
    required this.avatarUrl,
  });
}