class PatientCaseStudyRepositoryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PatientCaseStudyRepositoryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PatientCaseStudyRepositoryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PatientCaseStudyRepositoryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
