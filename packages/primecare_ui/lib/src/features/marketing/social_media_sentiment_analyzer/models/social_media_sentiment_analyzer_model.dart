import 'package:primecare_models/primecare_models.dart';

class SocialMediaSentimentAnalyzerModel extends BaseScreenState<SocialMediaSentimentAnalyzerModel> {
  const SocialMediaSentimentAnalyzerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  SocialMediaSentimentAnalyzerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => SocialMediaSentimentAnalyzerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
