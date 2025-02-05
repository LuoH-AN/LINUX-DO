import 'package:dio/dio.dart' hide Headers, MultipartFile;
import 'package:linux_do/models/docs.dart';
import 'package:linux_do/models/leaderboard.dart';
import 'package:retrofit/retrofit.dart';
import 'dart:convert';
import '../models/activity_stream.dart';
import '../models/birthday.dart';
import '../models/create_post_response.dart';
import '../models/group.dart';
import '../models/image_size.dart';
import '../models/login.dart';
import '../models/post_response.dart';
import '../models/topic_detail.dart';
import '../models/topic_model.dart';
import '../models/upload_image_response.dart';
import '../models/user.dart';
import '../models/summary.dart';
import '../models/user_action.dart';
import '../models/notification.dart';
import '../models/message.dart';
import '../models/badge_detail.dart';
import '../models/category_data.dart';
import '../models/tag_data.dart';
import '../models/search_result.dart';
import '../models/chat_response.dart';
import '../models/chat_messages_response.dart';
import 'http_config.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: HttpConfig.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  /// 获取CSRF Token
  @GET('session/csrf')
  Future<void> getCsrfToken();

  /// 登录
  @POST('session')
  Future<void> login(@Body() LoginRequest loginRequest);

  /// 获取首页话题
  @GET("{path}.json")
  Future<TopicListResponse> getTopics(@Path('path') String path,
      [@Query("page") int page = 1]);

  /// 设置某个话题免打扰
  @POST("t/{id}/notifications")
  @MultiPart()
  Future<dynamic> setTopicMute(@Path("id") String id,
      @Part(name: "notification_level") int notificationLevel);

  /// 获取帖子详情 - 首次加载和分页
  @GET("t/{id}{page}.json")
  @DioResponseType(ResponseType.json)
  Future<TopicDetail> getTopicDetail(
    @Path("id") String id, {
    @Path("page") String page = "",
    @Query("track_visit") bool trackVisit = true,
    @Query("forceLoad") bool forceLoad = true,
  });

  /// 获取帖子详情 - 加载指定帖子
  @GET("t/{id}/posts.json")
  @DioResponseType(ResponseType.json)
  Future<TopicDetail> getTopicPosts(
    @Path("id") String id, {
    @Query("post_ids[]") List<String> postIds = const [],
    @Query("include_suggested") bool includeSuggested = true,
  });

  /// 更新帖子阅读时间
  @POST("topics/timings")
  @MultiPart()
  Future<void> updateTopicTiming(
    @Part(name: "topic_id") String topicId,
    @Part(name: "topic_time") int topicTime,
    @Part(name: "timings") Map<String, int> timings,
  );

  /// 用户信息
  @GET('u/{current}.json')
  Future<UserResponse> getCurrentUser(@Path("current") String current);

  /// 总结数据
  @GET('u/{current}/summary.json')
  Future<SummaryResponse> getUserSummary(@Path("current") String current);

  /// 用户活动
  @GET('user_actions.json')
  Future<UserActionResponse> getUserActions(
    @Query("username") String username,
    @Query("offset") int offset,
    @Query("filter") String filter,
  );

  /// 通知
  @GET('notifications')
  Future<NotificationResponse> getNotifications(
    @Query("username") String username,
    @Query("limit") int limit,
    @Query("filter") String filter,
  );

  /// 消息/私信
  @GET('topics/private-messages/{username}.json')
  Future<MessageResponse> getMessages(@Path("username") String username,
      @Query('ascending') bool ascending, @Query('order') String order);

  /// 用户徽章
  @GET('user-badges/{current}.json')
  Future<BadgeDetailResponse> getUserBadges(
    @Path("current") String current, [
    @Query("only_listable") bool onlyListable = true,
    @Query("onlyListable") bool listable = true,
  ]);

  /// 全部徽章
  @GET('badges.json')
  Future<BadgeDetailResponse> getBadges([
    @Query("only_listable") bool onlyListable = true,
    @Query("onlyListable") bool listable = true,
  ]);

  /// 获取回复草稿
  @GET('drafts/topic_{topic_id}.json')
  Future<void> getTopicDraft(
    @Path('topic_id') String topicId,
  );

  /// 获取编辑器信息
  @GET('composer_messages')
  Future<void> getComposerMessages(
    @Query('composer_action') String composerAction,
    @Query('topic_id') String topicId,
  );

  /// 更新在线状态
  @PUT('presence/update')
  Future<void> updateChannelPresence(
    @Field('client_id') String clientId,
    @Field('present_channels[]') String channel,
  );

  /// 保存草稿
  @POST('drafts.json')
  Future<void> saveDraft(
    @Field('draft_key') String draftKey,
    @Field('sequence') int sequence,
    @Field('data') String data,
    @Field('owner') String owner,
    @Field('force_save') bool forceSave,
  );

  /// 发送回复
  @POST('posts.json')
  @FormUrlEncoded()
  Future<PostResponse> replyPost(
      @Field('topic_id') String topicId,
      @Field('raw') String content,
      @Field('nested_post') bool nestedPost,
      @Field('archetype') String archetype,
      @Field('category') String category,
      {@Field('reply_to_post_number') int? replyToPostNumber});

  /// 点赞帖子
  @PUT('discourse-reactions/posts/{post_id}/custom-reactions/heart/toggle.json')
  Future<Post> togglePostLike(@Path('post_id') String postId);

  @GET('categories.json')
  Future<CategoryListResponse> getCategories();

  /// 获取分类的权限等级统计
  @GET('c/{id}/l/{level}.json')
  Future<TopicListResponse> getCategoryLevelStats(
    @Path('id') int categoryId,
    @Path('level') int level,
  );

  @GET('tags/filter/search')
  Future<TagResponse> getTags(
    @Query('q') String query,
    @Query('limit') int limit,
    @Query('categoryId') int categoryId,
    @Query('filterForInput') bool filterForInput,
  );

  /// 上传图片
  @POST('uploads.json')
  @MultiPart()
  Future<UploadImageResponse> uploadImage(
    @Query('client_id') String clientId,
    @Body() FormData formData,
  );

  /// 发布新主题
  @POST('posts')
  @FormUrlEncoded()
  Future<CreatePostResponse> createPost({
    @Field('title') required String title,
    @Field('raw') required String content,
    @Field('category') required int categoryId,
    @Field('unlist_topic') bool unlistTopic = false,
    @Field('is_warning') bool isWarning = false,
    @Field('archetype') String archetype = 'regular',
    @Field('typing_duration_msecs') int typingDurationMsecs = 1000,
    @Field('composer_open_duration_msecs') int composerOpenDurationMsecs = 1000,
    @Field('nested_post') bool nestedPost = true,
    @Field('tags[]') required List<String> tags,
    @Field('image_sizes') required Map<String, ImageSize> imageSizes,
  });

  /// 搜索
  @GET('search')
  Future<SearchResult> search({
    @Query('q') required String query,
    @Query('page') int page = 1,
  });

  /// 获取聊天列表
  @GET('chat/api/me/channels')
  Future<ChatResponse> getChannels();

  /// 获取频道消息
  @GET('chat/api/channels/{channelId}/messages')
  Future<ChatMessagesResponse> getChannelMessages(
    @Path('channelId') int channelId, {
    @Query('fetch_from_last_read') bool? fetchFromLastRead,
    @Query('page_size') int? pageSize = 50,
    @Query('direction') String? direction,
    @Query('target_message_id') int? targetMessageId,
    @Query('position') String? position,
  });

  /// 发送消息
  @POST('chat/{channelId}')
  @FormUrlEncoded()
  Future<dynamic> sendMessage(
    @Path('channelId') int channelId,
    @Field('message') String message,
    @Field('staged_id') String? stagedId,
  );

  /// 更改在线状态
  @PUT('u/{current}.json')
  Future<UserResponse> updatePresence(
    @Path('current') String current,
    @Field('hide_presence') bool hidePresence,
  );

  /// 更新自定义状态
  @PUT('user-status.json')
  Future<dynamic> updateUserStatus(@Field('description') String description,
      {@Field('emoji') String emoji = 'speech_balloon'});

  /// 获取我的帖子列表
  @GET('posted.json')
  Future<TopicListResponse> getMyPosted([@Query("page") int? page = 1]);

  /// 获取我的书签列表
  @GET('bookmarks.json')
  Future<TopicListResponse> getMyBookmarks([@Query("page") int? page]);

  /// 获取文档列表
  @GET('docs.json')
  Future<Docs> getDocs([
    @Query("page") int? page,
    @Query("tags") String? tag,
    @Query("category") String? category,
  ]);

  /// 获取排行榜
  @GET('leaderboard{categoryId}')
  Future<LeaderboardResponse> getLeaderboard({
    @Path('categoryId') String categoryId = '',
    @Query('period') String period = 'all',
    @Query('page') int? page,
  });

  /// 离开群组
  @DELETE('groups/{group_id}/leave.json')
  Future<void> leaveGroup(@Path('group_id') int groupId);

  /// 加入群组
  @PUT('groups/{group_id}/join.json')
  Future<void> joinGroup(@Path('group_id') int groupId);

  /// 获取群组列表
  @GET('groups')
  Future<GroupResponse> getGroups();

  /// 获取活动列表
  @GET('discourse-post-event/events')
  Future<ActivityStreamResponse> getEventStream();

  /// 获取生日列表
  @GET('cakeday/birthdays')
  Future<BirthdayResponse> getBirthdays(
    [@Query('filter') String? filter,
    @Query('page') int? page,
    @Query('month') int? month,
  ]);
}
