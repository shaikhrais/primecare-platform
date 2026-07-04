class ClinicalAnalyticsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalAnalyticsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalAnalyticsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalAnalyticsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
