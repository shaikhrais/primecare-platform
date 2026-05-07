import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinical_article.freezed.dart';
part 'clinical_article.g.dart';

@freezed
abstract class ClinicalArticle with _$ClinicalArticle {
  const factory ClinicalArticle({
    required String url,
    required String title,
    required String category,
    required String content,
    @JsonKey(name: 'html_content') required String htmlContent,
  }) = _ClinicalArticle;

  factory ClinicalArticle.fromJson(Map<String, dynamic> json) => _$ClinicalArticleFromJson(json);
}
