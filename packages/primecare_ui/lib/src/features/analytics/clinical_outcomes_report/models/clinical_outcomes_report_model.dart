class ClinicalOutcomesReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalOutcomesReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalOutcomesReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalOutcomesReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
