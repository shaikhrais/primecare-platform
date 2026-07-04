class ChiropractorAssessmentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorAssessmentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorAssessmentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorAssessmentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
