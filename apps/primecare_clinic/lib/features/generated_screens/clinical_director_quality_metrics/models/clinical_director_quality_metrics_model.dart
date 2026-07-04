class ClinicalDirectorQualityMetricsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalDirectorQualityMetricsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalDirectorQualityMetricsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalDirectorQualityMetricsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
