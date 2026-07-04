class SocialMediaSentimentAnalyzerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SocialMediaSentimentAnalyzerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SocialMediaSentimentAnalyzerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SocialMediaSentimentAnalyzerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
