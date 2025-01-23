import 'http_client.dart';
import 'api_response.dart';
import '../models/post.dart';

class ApiService {
  static final _client = HttpClient.instance;

  /// 获取帖子列表
  static Future<ApiResponse<List<Post>>> getPosts({
    int page = 1,
    int limit = 10,
  }) async {
    return await _client.rest.getPosts(page, limit);
  }

  /// 获取帖子详情
  static Future<ApiResponse<Post>> getPostDetail(String id) async {
    return await _client.rest.getPostDetail(id);
  }

  /// 创建帖子
  static Future<ApiResponse<Post>> createPost({
    required String title,
    required String content,
  }) async {
    return await _client.rest.createPost({
      'title': title,
      'content': content,
    });
  }

  /// 更新帖子
  static Future<ApiResponse<Post>> updatePost({
    required String id,
    String? title,
    String? content,
  }) async {
    final data = <String, dynamic>{};
    if (title != null) data['title'] = title;
    if (content != null) data['content'] = content;

    return await _client.rest.updatePost(id, data);
  }

  /// 删除帖子
  static Future<ApiResponse<void>> deletePost(String id) async {
    return await _client.rest.deletePost(id);
  }
}
