import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_media_sentiment_analyzer_model.dart';

class SocialMediaSentimentAnalyzerNotifier extends StateNotifier<SocialMediaSentimentAnalyzerModel> {
  SocialMediaSentimentAnalyzerNotifier() : super(const SocialMediaSentimentAnalyzerModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final social_media_sentiment_analyzerProvider = StateNotifierProvider<SocialMediaSentimentAnalyzerNotifier, SocialMediaSentimentAnalyzerModel>((ref) {
  return SocialMediaSentimentAnalyzerNotifier()..loadData();
});
