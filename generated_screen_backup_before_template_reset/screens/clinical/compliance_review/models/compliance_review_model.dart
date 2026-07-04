class ComplianceReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ComplianceReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ComplianceReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ComplianceReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
