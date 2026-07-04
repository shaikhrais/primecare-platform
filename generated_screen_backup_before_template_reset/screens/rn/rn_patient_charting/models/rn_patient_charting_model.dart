class RnPatientChartingModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnPatientChartingModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnPatientChartingModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnPatientChartingModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
