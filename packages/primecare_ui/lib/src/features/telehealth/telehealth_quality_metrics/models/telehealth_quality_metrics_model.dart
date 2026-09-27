class TelehealthQualityMetricsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const TelehealthQualityMetricsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  TelehealthQualityMetricsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return TelehealthQualityMetricsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
