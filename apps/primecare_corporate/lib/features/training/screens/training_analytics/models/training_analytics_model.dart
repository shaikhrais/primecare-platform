class TrainingAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TrainingAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TrainingAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TrainingAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
