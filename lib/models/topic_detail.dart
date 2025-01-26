import 'package:json_annotation/json_annotation.dart';

part 'topic_detail.g.dart';

@JsonSerializable()
class TopicDetail {
  final int id;
  final String title;
  @JsonKey(name: 'fancy_title')
  final String fancyTitle;
  @JsonKey(name: 'posts_count')
  final int postsCount;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final int views;
  @JsonKey(name: 'reply_count')
  final int replyCount;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'last_posted_at')
  final String lastPostedAt;
  final bool? visible;
  final bool? closed;
  final bool? archived;
  final String archetype;
  final String slug;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'word_count')
  final int wordCount;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'post_stream')
  final PostStream postStream;

  TopicDetail({
    required this.id,
    required this.title,
    required this.fancyTitle,
    required this.postsCount,
    required this.createdAt,
    required this.views,
    required this.replyCount,
    required this.likeCount,
    required this.lastPostedAt,
    this.visible,
    this.closed,
    this.archived,
    required this.archetype,
    required this.slug,
    required this.categoryId,
    required this.wordCount,
    required this.userId,
    required this.postStream,
  });

  factory TopicDetail.fromJson(Map<String, dynamic> json) =>
      _$TopicDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TopicDetailToJson(this);
}

@JsonSerializable()
class PostStream {
  final List<Post> posts;
  final List<int> stream;

  PostStream({
    required this.posts,
    required this.stream,
  });

  factory PostStream.fromJson(Map<String, dynamic> json) =>
      _$PostStreamFromJson(json);
  Map<String, dynamic> toJson() => _$PostStreamToJson(this);
}

@JsonSerializable()
class Post {
  final int id;
  final String name;
  final String username;
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;
  @JsonKey(name: 'created_at')
  final String createdAt;
  final String cooked;
  @JsonKey(name: 'post_number')
  final int postNumber;
  @JsonKey(name: 'post_type')
  final int postType;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'reply_count')
  final int replyCount;
  @JsonKey(name: 'quote_count')
  final int quoteCount;
  @JsonKey(name: 'incoming_link_count')
  final int incomingLinkCount;
  final int reads;
  final double score;
  final bool? yours;
  @JsonKey(name: 'topic_id')
  final int topicId;
  @JsonKey(name: 'topic_slug')
  final String topicSlug;
  @JsonKey(name: 'display_username')
  final String displayUsername;
  @JsonKey(name: 'primary_group_name')
  final String? primaryGroupName;
  final bool? hidden;
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  @JsonKey(name: 'user_title')
  final String? userTitle;
  final bool? bookmarked;
  @JsonKey(name: 'actions_summary')
  final List<ActionSummary>? actionsSummary;

  Post({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarTemplate,
    required this.createdAt,
    required this.cooked,
    required this.postNumber,
    required this.postType,
    required this.updatedAt,
    required this.replyCount,
    required this.quoteCount,
    required this.incomingLinkCount,
    required this.reads,
    required this.score,
    this.yours,
    required this.topicId,
    required this.topicSlug,
    required this.displayUsername,
    this.primaryGroupName,
    this.hidden,
    required this.trustLevel,
    this.userTitle,
    this.bookmarked,
    this.actionsSummary,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class ActionSummary {
  final int id;
  final int? count;
  final bool? hidden;
  @JsonKey(name: 'can_act')
  final bool? canAct;

  ActionSummary({
    required this.id,
    this.count,
    this.hidden,
    this.canAct,
  });

  factory ActionSummary.fromJson(Map<String, dynamic> json) =>
      _$ActionSummaryFromJson(json);
  Map<String, dynamic> toJson() => _$ActionSummaryToJson(this);
}
