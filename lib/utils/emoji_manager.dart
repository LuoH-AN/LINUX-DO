import 'dart:convert';
import 'package:flutter/services.dart';
import '../utils/log.dart';

class EmojiData {
  final String name;
  final bool tonable;
  final String url;
  final String group;
  final List<String> searchAliases;

  EmojiData({
    required this.name,
    required this.tonable,
    required this.url,
    required this.group,
    required this.searchAliases,
  });

  factory EmojiData.fromJson(Map<String, dynamic> json) {
    return EmojiData(
      name: json['name'] as String,
      tonable: json['tonable'] as bool,
      url: json['url'] as String,
      group: json['group'] as String,
      searchAliases: (json['search_aliases'] as List<dynamic>).cast<String>(),
    );
  }
}

class EmojiManager {
  static EmojiManager? _instance;
  Map<String, List<EmojiData>>? _emojiData;
  bool _isLoading = false;

  static EmojiManager get instance {
    _instance ??= EmojiManager._();
    return _instance!;
  }

  EmojiManager._();

  Future<Map<String, List<EmojiData>>> getEmojiData() async {
    if (_emojiData != null) {
      return _emojiData!;
    }

    if (_isLoading) {
      // 等待加载完成
      while (_isLoading) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return _emojiData!;
    }

    _isLoading = true;
    try {
      final String jsonString = await rootBundle.loadString('assets/json/emojis.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      _emojiData = {};
      jsonData.forEach((key, value) {
        final List<dynamic> emojiList = value as List<dynamic>;
        _emojiData![key] = emojiList
            .map((e) => EmojiData.fromJson(e as Map<String, dynamic>))
            .toList();
      });

      return _emojiData!;
    } catch (e, stack) {
      l.e('加载表情数据失败: $e\n$stack');
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  void clearCache() {
    _emojiData = null;
  }
} 