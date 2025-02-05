import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:linux_do/controller/base_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../controller/global_controller.dart';
import '../../models/chat_detail_message.dart';
import '../../models/chat_message.dart';
import '../../net/api_service.dart';
import '../../utils/log.dart';
import 'dart:async';
import 'package:linux_do/models/user.dart';

class ChatDetailController extends BaseController {
  final ApiService apiService = Get.find();
  late ChatMessage channel = Get.arguments;
  final Rxn<CurrentUser> _user = Rxn<CurrentUser>();

  ChatDetailController() {
    _user.value = Get.find<GlobalController>().userInfo?.user;
  }

  // 输入控制器
  final inputController = TextEditingController();
  final focusNode = FocusNode();

  // 消息列表
  final RxList<ChatDetailMessage> messages = <ChatDetailMessage>[].obs;

  // 滚动控制器
  final itemScrollController = ItemScrollController();
  final itemPositionsListener = ItemPositionsListener.create();

  // 是否可以加载更多历史消息
  bool canLoadMorePast = false;
  // 是否可以加载更多新消息
  bool canLoadMoreFuture = false;
  
  // 是否正在加载更多
  bool _isLoadingMore = false;
  // 防抖计时器
  Timer? _scrollDebounce;

  final refreshController = RefreshController();

  // MessageBus 相关
  int _channelMessageBusId = -1;
  Timer? _messageBusTimer;
  bool _isSubscribed = false;

  @override
  void onInit() {
    super.onInit();
    // 监听滚动位置
    itemPositionsListener.itemPositions.addListener(_onScroll);
    // 加载消息
    loadMessages();
    
    // 订阅 MessageBus
    // 不知道怎么实现 去掉轮训  
    // _subscribeToMessageBus();
  }

  @override
  void onClose() {
    inputController.dispose();
    focusNode.dispose();
    itemPositionsListener.itemPositions.removeListener(_onScroll);
    _scrollDebounce?.cancel();
    _messageBusTimer?.cancel();
    _isSubscribed = false;
    super.onClose();
  }

  void _onScroll() {
    // 取消之前的延迟执行
    _scrollDebounce?.cancel();
    
    // 创建新的延迟执行
    _scrollDebounce = Timer(const Duration(milliseconds: 200), () {
      if (_isLoadingMore) return;
      
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isEmpty) return;

      // 获取第一个和最后一个可见项的位置
      final min = positions.first.index;
      final max = positions.last.index;

      // 如果第一个可见项是列表的第一项，并且可以加载更多历史消息
      l.d('min: $min, max: $max');
      if (min < 10) {
        loadMorePastMessages();
      }

      // // 如果最后一个可见项是列表的最后一项，并且可以加载更多新消息
      // if (max == messages.length - 1 && canLoadMoreFuture) {
      //   loadMoreFutureMessages();
      // }
    });
  }

  // 发送消息
  Future<void> sendMessage() async {
    final content = inputController.text.trim();
    if (content.isEmpty) return;
    
    l.d('用户信息: ${_user.value?.id} ${_user.value?.username} ${_user.value?.name}');
    try {
      // 生成一个临时ID
      final stagedId = DateTime.now().millisecondsSinceEpoch.toString();
      
      // 创建一个临时消息对象
      final tempMessage = ChatDetailMessage(
        id: null,  // 服务器会返回真实ID
        message: content,
        cooked: content,
        createdAt: DateTime.now().toIso8601String(),
        channelId: channel.id,
        streaming: false,
        user: ChatMessageUser(
          id: _user.value?.id ?? 0,
          username: _user.value?.username ?? '',
          name: _user.value?.name ?? '',
          avatarTemplate: _user.value?.avatarTemplate ?? '',
        ),
      );

      // 先添加到消息列表
      messages.add(tempMessage);
      
      // 清空输入框
      inputController.clear();

      // 滚动到底部
      Future.delayed(const Duration(milliseconds: 100), () {
        if (itemScrollController.isAttached) {
          itemScrollController.scrollTo(
            index: messages.length - 1,
            duration: const Duration(milliseconds: 300),
          );
        }
      });

      // 发送消息到服务器
      final response = await apiService.sendMessage(
        channel.id,
        content,
        stagedId,
      );

      // 如果发送成功，更新消息的ID
      if (response['success'] == 'OK' && response['message_id'] != null) {
        final index = messages.indexOf(tempMessage);
        if (index != -1) {
          messages[index] = ChatDetailMessage(
            id: response['message_id'],
            message: content,
            cooked: content,
            createdAt: DateTime.now().toIso8601String(),
            channelId: channel.id,
            streaming: false,
            user: tempMessage.user,
          );
        }
      }
    } catch (e, s) {
      l.e('发送消息失败: $e $s');
      showError('发送失败，请重试');
      
      // 从消息列表中移除失败的消息
      messages.removeWhere((msg) => msg.id == null && msg.message == content);
    }
  }

  // 加载消息
  Future<void> loadMessages() async {
    try {
      isLoading.value = true;

      final response = await apiService.getChannelMessages(
        channel.id,
        pageSize: 50,
        position: 'end',
      );

      messages.clear();
      messages.addAll(response.messages);

      canLoadMorePast = response.meta.canLoadMorePast;
      canLoadMoreFuture = response.meta.canLoadMoreFuture;

      // 滚动到底部
      Future.delayed(const Duration(milliseconds: 5), () {
        if (itemScrollController.isAttached) {
          itemScrollController.scrollTo(
            index: messages.length - 1,
            duration: const Duration(milliseconds: 5),
          );
        }
      });
    } catch (e, s) {
      l.e('加载消息失败 $e $s');
      showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 加载更多历史消息
  Future<void> loadMorePastMessages() async {
    l.d('_isLoadingMore: $_isLoadingMore');
    if (!canLoadMorePast || _isLoadingMore) return;
    
    _isLoadingMore = true;
    l.d('加载更多历史消息');
    
    try {
      final firstMessage = messages.first;
      final oldMessagesLength = messages.length;
      
      final response = await apiService.getChannelMessages(
        channel.id,
        targetMessageId: firstMessage.id,
        direction: 'past',
        pageSize: 50,
      );

      messages.insertAll(0, response.messages);
      canLoadMorePast = response.meta.canLoadMorePast;

      if (messages.length > oldMessagesLength) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (itemScrollController.isAttached) {
            itemScrollController.scrollTo(
              index: response.messages.length,
              duration: const Duration(milliseconds: 100),
            );
          }
        });
      }
    } catch (e, s) {
      l.e('加载更多历史消息失败: $e $s');
      showError(e.toString());
    } finally {
      _isLoadingMore = false;
      refreshController.refreshCompleted();
    }
  }

  // 加载更多新消息
  Future<void> loadMoreFutureMessages() async {
    if (!canLoadMoreFuture || _isLoadingMore) return;
    
    _isLoadingMore = true;
    
    try {
      final lastMessage = messages.last;
      final response = await apiService.getChannelMessages(
        channel.id,
        targetMessageId: lastMessage.id,
        direction: 'future',
        pageSize: 50,
      );

      messages.addAll(response.messages.reversed);
      canLoadMoreFuture = response.meta.canLoadMoreFuture;
    } catch (e, s) {
      l.e('加载更多新消息失败: $e $s');
      showError(e.toString());
    } finally {
      _isLoadingMore = false;
    }
  }

  // 订阅 MessageBus
  void _subscribeToMessageBus() {
    if (_isSubscribed) return;
    _isSubscribed = true;

    // 获取初始的 message_bus_id
    _channelMessageBusId = channel.meta.messageBusLastIds.channelMessageBusLastId;
    
    // 开始监听消息
    _pollMessages();
  }

  // 轮询消息
  void _pollMessages() async {
    if (!_isSubscribed) return;

    try {
      final response = await apiService.getChannelMessages(
        channel.id,
        fetchFromLastRead: false,
        pageSize: 20,
        direction: 'future',
        targetMessageId: _channelMessageBusId,
      );

      if (response.messages.isNotEmpty) {
        // 更新最后的消息ID
        _channelMessageBusId = response.messages.last.id ?? _channelMessageBusId;
        
        // 添加新消息
        messages.addAll(response.messages);
        
        // 如果用户在底部，自动滚动到最新消息
        if (_isUserAtBottom()) {
          _scrollToBottom();
        }
      }

      // 等待一段时间后再次轮询
      _messageBusTimer?.cancel();
      _messageBusTimer = Timer(const Duration(seconds: 50), _pollMessages);
      
    } catch (e, s) {
      l.e('消息轮询失败: $e $s');
      
      // 如果失败，等待一段时间后重试
      _messageBusTimer?.cancel();
      _messageBusTimer = Timer(const Duration(seconds: 80), _pollMessages);
    }
  }

  // 判断用户是否在底部
  bool _isUserAtBottom() {
    if (!itemPositionsListener.itemPositions.value.isNotEmpty) return true;
    
    final positions = itemPositionsListener.itemPositions.value;
    final lastIndex = messages.length - 1;
    
    for (final position in positions) {
      if (position.index == lastIndex) {
        return true;
      }
    }
    return false;
  }
  
  // 滚动到底部
  void _scrollToBottom() {
    if (messages.isEmpty || !itemScrollController.isAttached) return;
    
    itemScrollController.scrollTo(
      index: messages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
