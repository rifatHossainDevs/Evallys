// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      author: json['author'] == null
          ? null
          : AuthorV2.fromJson(json['author'] as Map<String, dynamic>),
      commentList: (json['commentList'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
      contentHtml: json['contentHtml'] as String?,
      excerpt: json['excerpt'] as String?,
      excerptHtml: json['excerptHtml'] as String?,
      handle: json['handle'] as String?,
      id: json['id'] as String?,
      image: json['image'] == null
          ? null
          : ShopifyImage.fromJson(json['image'] as Map<String, dynamic>),
      publishedAt: json['publishedAt'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String?,
      onlineStoreUrl: json['onlineStoreUrl'] as String?,
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'author': instance.author,
      'commentList': instance.commentList,
      'content': instance.content,
      'contentHtml': instance.contentHtml,
      'excerpt': instance.excerpt,
      'excerptHtml': instance.excerptHtml,
      'handle': instance.handle,
      'id': instance.id,
      'image': instance.image,
      'publishedAt': instance.publishedAt,
      'tags': instance.tags,
      'title': instance.title,
      'onlineStoreUrl': instance.onlineStoreUrl,
    };
