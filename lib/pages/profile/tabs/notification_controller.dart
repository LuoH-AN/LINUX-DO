import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controller/base_controller.dart';
import '../../../models/notification.dart';
import '../../../net/api_service.dart';
import '../../../utils/log.dart';
import '../../../utils/mixins/concatenated.dart';

class NotificationController extends BaseController with Concatenated {
  final ApiService _apiService = Get.find();
  final notifications = <NotificationItem>[].obs;
  late final RefreshController refreshController;
  
  static const int _pageSize = 60;
  bool _hasMore = true;
  bool _isFirstLoad = true;
  
  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
    _loadNotifications();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> _loadNotifications() async {
    if (isUserEmpty()) return;
   
    try {
      isLoading.value = _isFirstLoad;
      final response = await _apiService.getNotifications(
        userName,
        _pageSize,
        'all',
      );
      l.i('加载通知数据: ${jsonEncode(response)}');
      
      if (response.notifications.isNotEmpty) {
        notifications.addAll(response.notifications);
        _hasMore = response.notifications.length >= _pageSize;
        refreshController.loadComplete();
      } else {
        _hasMore = false;
        refreshController.loadNoData();
      }
      _isFirstLoad = false;
    } catch (e, stack) {
      l.e('加载通知数据失败: $e\n$stack');
      refreshController.loadFailed();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onLoadMore() async {
    if (!_hasMore) {
      refreshController.loadNoData();
      return;
    }
    await _loadNotifications();
  }
} 