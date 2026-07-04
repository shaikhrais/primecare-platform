class ClinicalDirectorIncidentReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClinicalDirectorIncidentReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClinicalDirectorIncidentReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClinicalDirectorIncidentReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
