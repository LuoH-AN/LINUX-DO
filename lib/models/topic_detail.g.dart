// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicDetail _$TopicDetailFromJson(Map<String, dynamic> json) => TopicDetail(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      fancyTitle: json['fancy_title'] as String?,
      postsCount: (json['posts_count'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      views: (json['views'] as num?)?.toInt(),
      replyCount: (json['reply_count'] as num?)?.toInt(),
      likeCount: (json['like_count'] as num?)?.toInt(),
      lastPostedAt: json['last_posted_at'] as String?,
      visible: json['visible'] as bool?,
      closed: json['closed'] as bool?,
      archived: json['archived'] as bool?,
      archetype: json['archetype'] as String?,
      slug: json['slug'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      wordCount: (json['word_count'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      postStream: json['post_stream'] == null
          ? null
          : PostStream.fromJson(json['post_stream'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopicDetailToJson(TopicDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fancy_title': instance.fancyTitle,
      'posts_count': instance.postsCount,
      'created_at': instance.createdAt,
      'views': instance.views,
      'reply_count': instance.replyCount,
      'like_count': instance.likeCount,
      'last_posted_at': instance.lastPostedAt,
      'visible': instance.visible,
      'closed': instance.closed,
      'archived': instance.archived,
      'archetype': instance.archetype,
      'slug': instance.slug,
      'category_id': instance.categoryId,
      'word_count': instance.wordCount,
      'user_id': instance.userId,
      'post_stream': instance.postStream,
    };

PostStream _$PostStreamFromJson(Map<String, dynamic> json) => PostStream(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      stream: (json['stream'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$PostStreamToJson(PostStream instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'stream': instance.stream,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      username: json['username'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      avatarTemplate: json['avatar_template'] as String?,
      createdAt: json['created_at'] as String?,
      cooked: json['cooked'] as String?,
      postNumber: (json['post_number'] as num?)?.toInt(),
      postType: (json['post_type'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      replyCount: (json['reply_count'] as num?)?.toInt(),
      quoteCount: (json['quote_count'] as num?)?.toInt(),
      incomingLinkCount: (json['incoming_link_count'] as num?)?.toInt(),
      reads: (json['reads'] as num?)?.toInt(),
      score: (json['score'] as num?)?.toDouble(),
      yours: json['yours'] as bool?,
      topicId: (json['topic_id'] as num?)?.toInt(),
      topicSlug: json['topic_slug'] as String?,
      displayUsername: json['display_username'] as String?,
      primaryGroupName: json['primary_group_name'] as String?,
      hidden: json['hidden'] as bool?,
      trustLevel: (json['trust_level'] as num?)?.toInt(),
      userTitle: json['user_title'] as String?,
      bookmarked: json['bookmarked'] as bool?,
      actionsSummary: (json['actions_summary'] as List<dynamic>?)
          ?.map((e) => ActionSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'user_id': instance.userId,
      'avatar_template': instance.avatarTemplate,
      'created_at': instance.createdAt,
      'cooked': instance.cooked,
      'post_number': instance.postNumber,
      'post_type': instance.postType,
      'updated_at': instance.updatedAt,
      'reply_count': instance.replyCount,
      'quote_count': instance.quoteCount,
      'incoming_link_count': instance.incomingLinkCount,
      'reads': instance.reads,
      'score': instance.score,
      'yours': instance.yours,
      'topic_id': instance.topicId,
      'topic_slug': instance.topicSlug,
      'display_username': instance.displayUsername,
      'primary_group_name': instance.primaryGroupName,
      'hidden': instance.hidden,
      'trust_level': instance.trustLevel,
      'user_title': instance.userTitle,
      'bookmarked': instance.bookmarked,
      'actions_summary': instance.actionsSummary,
    };

ActionSummary _$ActionSummaryFromJson(Map<String, dynamic> json) =>
    ActionSummary(
      id: (json['id'] as num).toInt(),
      count: (json['count'] as num?)?.toInt(),
      hidden: json['hidden'] as bool?,
      canAct: json['can_act'] as bool?,
    );

Map<String, dynamic> _$ActionSummaryToJson(ActionSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'hidden': instance.hidden,
      'can_act': instance.canAct,
    };
