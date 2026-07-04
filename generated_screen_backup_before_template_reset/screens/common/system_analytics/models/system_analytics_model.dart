class SystemAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SystemAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SystemAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SystemAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
