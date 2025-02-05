// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponse _$SummaryResponseFromJson(Map<String, dynamic> json) =>
    SummaryResponse(
      topics: (json['topics'] as List<dynamic>?)
          ?.map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      badgeTypes: (json['badge_types'] as List<dynamic>?)
          ?.map((e) => BadgeType.fromJson(e as Map<String, dynamic>))
          .toList(),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      userSummary: json['user_summary'] == null
          ? null
          : UserSummary.fromJson(json['user_summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) =>
    <String, dynamic>{
      'topics': instance.topics,
      'badges': instance.badges,
      'badge_types': instance.badgeTypes,
      'users': instance.users,
      'user_summary': instance.userSummary,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      fancyTitle: json['fancy_title'] as String?,
      slug: json['slug'] as String?,
      postsCount: (json['posts_count'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      views: (json['views'] as num?)?.toInt(),
      replyCount: (json['reply_count'] as num?)?.toInt(),
      likeCount: (json['like_count'] as num?)?.toInt(),
      lastPostedAt: json['last_posted_at'] as String?,
      visible: json['visible'] as bool?,
      closed: json['closed'] as bool?,
      archived: json['archived'] as bool?,
      hasSummary: json['has_summary'] as bool?,
      archetype: json['archetype'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      pinnedGlobally: json['pinned_globally'] as bool?,
      featuredLink: json['featured_link'] as String?,
      hasAcceptedAnswer: json['has_accepted_answer'] as bool?,
      posters: (json['posters'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'fancy_title': instance.fancyTitle,
      'slug': instance.slug,
      'posts_count': instance.postsCount,
      'created_at': instance.createdAt,
      'views': instance.views,
      'reply_count': instance.replyCount,
      'like_count': instance.likeCount,
      'last_posted_at': instance.lastPostedAt,
      'visible': instance.visible,
      'closed': instance.closed,
      'archived': instance.archived,
      'has_summary': instance.hasSummary,
      'archetype': instance.archetype,
      'category_id': instance.categoryId,
      'pinned_globally': instance.pinnedGlobally,
      'featured_link': instance.featuredLink,
      'has_accepted_answer': instance.hasAcceptedAnswer,
      'posters': instance.posters,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      grantCount: (json['grant_count'] as num).toInt(),
      allowTitle: json['allow_title'] as bool,
      multipleGrant: json['multiple_grant'] as bool,
      icon: json['icon'] as String,
      imageUrl: json['image_url'] as String?,
      listable: json['listable'] as bool,
      enabled: json['enabled'] as bool,
      badgeGroupingId: (json['badge_grouping_id'] as num).toInt(),
      system: json['system'] as bool,
      slug: json['slug'] as String,
      manuallyGrantable: json['manually_grantable'] as bool,
      showInPostHeader: json['show_in_post_header'] as bool,
      badgeTypeId: (json['badge_type_id'] as num).toInt(),
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'grant_count': instance.grantCount,
      'allow_title': instance.allowTitle,
      'multiple_grant': instance.multipleGrant,
      'icon': instance.icon,
      'image_url': instance.imageUrl,
      'listable': instance.listable,
      'enabled': instance.enabled,
      'badge_grouping_id': instance.badgeGroupingId,
      'system': instance.system,
      'slug': instance.slug,
      'manually_grantable': instance.manuallyGrantable,
      'show_in_post_header': instance.showInPostHeader,
      'badge_type_id': instance.badgeTypeId,
    };

BadgeType _$BadgeTypeFromJson(Map<String, dynamic> json) => BadgeType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sortOrder: (json['sort_order'] as num).toInt(),
    );

Map<String, dynamic> _$BadgeTypeToJson(BadgeType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sortOrder,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      name: json['name'] as String,
      avatarTemplate: json['avatar_template'] as String,
      trustLevel: (json['trust_level'] as num).toInt(),
      animatedAvatar: json['animated_avatar'] as String?,
      admin: json['admin'] as bool?,
      moderator: json['moderator'] as bool?,
      flairName: json['flair_name'] as String?,
      flairUrl: json['flair_url'] as String?,
      flairBgColor: json['flair_bg_color'] as String?,
      flairColor: json['flair_color'] as String?,
      primaryGroupName: json['primary_group_name'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'avatar_template': instance.avatarTemplate,
      'trust_level': instance.trustLevel,
      'animated_avatar': instance.animatedAvatar,
      'admin': instance.admin,
      'moderator': instance.moderator,
      'flair_name': instance.flairName,
      'flair_url': instance.flairUrl,
      'flair_bg_color': instance.flairBgColor,
      'flair_color': instance.flairColor,
      'primary_group_name': instance.primaryGroupName,
      'count': instance.count,
    };

UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) => UserSummary(
      likesGiven: (json['likes_given'] as num?)?.toInt(),
      likesReceived: (json['likes_received'] as num?)?.toInt(),
      topicsEntered: (json['topics_entered'] as num?)?.toInt(),
      postsReadCount: (json['posts_read_count'] as num?)?.toInt(),
      daysVisited: (json['days_visited'] as num?)?.toInt(),
      topicCount: (json['topic_count'] as num?)?.toInt(),
      postCount: (json['post_count'] as num?)?.toInt(),
      timeRead: (json['time_read'] as num?)?.toInt(),
      recentTimeRead: (json['recent_time_read'] as num?)?.toInt(),
      bookmarkCount: (json['bookmark_count'] as num?)?.toInt(),
      canSeeSummaryStats: json['can_see_summary_stats'] as bool?,
      canSeeUserActions: json['can_see_user_actions'] as bool?,
      solvedCount: (json['solved_count'] as num?)?.toInt(),
      topicIds: (json['topic_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Reply.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostLikedByUsers: (json['most_liked_by_users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostLikedUsers: (json['most_liked_users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostRepliedToUsers: (json['most_replied_to_users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => UserBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      topCategories: (json['top_categories'] as List<dynamic>?)
          ?.map((e) => TopCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserSummaryToJson(UserSummary instance) =>
    <String, dynamic>{
      'likes_given': instance.likesGiven,
      'likes_received': instance.likesReceived,
      'topics_entered': instance.topicsEntered,
      'posts_read_count': instance.postsReadCount,
      'days_visited': instance.daysVisited,
      'topic_count': instance.topicCount,
      'post_count': instance.postCount,
      'time_read': instance.timeRead,
      'recent_time_read': instance.recentTimeRead,
      'bookmark_count': instance.bookmarkCount,
      'can_see_summary_stats': instance.canSeeSummaryStats,
      'can_see_user_actions': instance.canSeeUserActions,
      'solved_count': instance.solvedCount,
      'topic_ids': instance.topicIds,
      'replies': instance.replies,
      'links': instance.links,
      'most_liked_by_users': instance.mostLikedByUsers,
      'most_liked_users': instance.mostLikedUsers,
      'most_replied_to_users': instance.mostRepliedToUsers,
      'badges': instance.badges,
      'top_categories': instance.topCategories,
    };

Reply _$ReplyFromJson(Map<String, dynamic> json) => Reply(
      postNumber: (json['post_number'] as num).toInt(),
      likeCount: (json['like_count'] as num).toInt(),
      createdAt: json['created_at'] as String,
      topicId: (json['topic_id'] as num).toInt(),
    );

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'post_number': instance.postNumber,
      'like_count': instance.likeCount,
      'created_at': instance.createdAt,
      'topic_id': instance.topicId,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String,
      title: json['title'] as String?,
      clicks: (json['clicks'] as num).toInt(),
      postNumber: (json['post_number'] as num).toInt(),
      topicId: (json['topic_id'] as num).toInt(),
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'clicks': instance.clicks,
      'post_number': instance.postNumber,
      'topic_id': instance.topicId,
    };

UserBadge _$UserBadgeFromJson(Map<String, dynamic> json) => UserBadge(
      id: (json['id'] as num).toInt(),
      grantedAt: json['granted_at'] as String,
      createdAt: json['created_at'] as String,
      count: (json['count'] as num).toInt(),
      badgeId: (json['badge_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      grantedById: (json['granted_by_id'] as num).toInt(),
    );

Map<String, dynamic> _$UserBadgeToJson(UserBadge instance) => <String, dynamic>{
      'id': instance.id,
      'granted_at': instance.grantedAt,
      'created_at': instance.createdAt,
      'count': instance.count,
      'badge_id': instance.badgeId,
      'user_id': instance.userId,
      'granted_by_id': instance.grantedById,
    };

TopCategory _$TopCategoryFromJson(Map<String, dynamic> json) => TopCategory(
      topicCount: (json['topic_count'] as num).toInt(),
      postCount: (json['post_count'] as num).toInt(),
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String,
      textColor: json['text_color'] as String,
      slug: json['slug'] as String,
      readRestricted: json['read_restricted'] as bool,
      parentCategoryId: (json['parent_category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TopCategoryToJson(TopCategory instance) =>
    <String, dynamic>{
      'topic_count': instance.topicCount,
      'post_count': instance.postCount,
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'text_color': instance.textColor,
      'slug': instance.slug,
      'read_restricted': instance.readRestricted,
      'parent_category_id': instance.parentCategoryId,
    };
