// Governance - Category: model | Purpose: Returns a truncated version of the content for display in lists.
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinical_article.freezed.dart';
part 'clinical_article.g.dart';

@freezed
abstract class ClinicalArticle with _$ClinicalArticle {
  const ClinicalArticle._();

  const factory ClinicalArticle({
    required String url,
    required String title,
    required String category,
    required String content,
    @JsonKey(name: 'html_content') required String htmlContent,
  }) = _ClinicalArticle;

  factory ClinicalArticle.fromJson(Map<String, dynamic> json) =>
      _$ClinicalArticleFromJson(json);

  /// Returns a truncated version of the content for display in lists.
  String get summary {
    if (content.length <= 300) return content;
    return '${content.substring(0, 300).trim()}...';
  }
}
