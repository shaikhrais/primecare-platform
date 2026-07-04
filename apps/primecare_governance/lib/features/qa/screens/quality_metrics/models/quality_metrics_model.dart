class QualityMetricsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityMetricsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityMetricsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityMetricsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
