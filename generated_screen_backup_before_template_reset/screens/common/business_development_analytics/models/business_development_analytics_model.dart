class BusinessDevelopmentAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const BusinessDevelopmentAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  BusinessDevelopmentAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return BusinessDevelopmentAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
