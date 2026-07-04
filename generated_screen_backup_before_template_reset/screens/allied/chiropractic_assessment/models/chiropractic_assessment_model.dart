class ChiropracticAssessmentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropracticAssessmentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropracticAssessmentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropracticAssessmentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
