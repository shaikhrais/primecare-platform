class MassageAssessmentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MassageAssessmentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MassageAssessmentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MassageAssessmentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
