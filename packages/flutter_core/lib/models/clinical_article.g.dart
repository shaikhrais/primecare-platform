// Governance - Category: model | Purpose: GENERATED CODE - DO NOT MODIFY BY HAND JsonSerializableGenerator
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClinicalArticle _$ClinicalArticleFromJson(Map<String, dynamic> json) =>
    _ClinicalArticle(
      url: json['url'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      content: json['content'] as String,
      htmlContent: json['html_content'] as String,
    );

Map<String, dynamic> _$ClinicalArticleToJson(_ClinicalArticle instance) =>
    <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'category': instance.category,
      'content': instance.content,
      'html_content': instance.htmlContent,
    };
