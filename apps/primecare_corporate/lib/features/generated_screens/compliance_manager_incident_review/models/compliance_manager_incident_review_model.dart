class ComplianceManagerIncidentReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ComplianceManagerIncidentReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ComplianceManagerIncidentReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ComplianceManagerIncidentReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
