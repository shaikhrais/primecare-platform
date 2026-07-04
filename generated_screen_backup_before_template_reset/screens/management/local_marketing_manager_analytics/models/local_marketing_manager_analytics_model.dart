class LocalMarketingManagerAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const LocalMarketingManagerAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  LocalMarketingManagerAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return LocalMarketingManagerAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
