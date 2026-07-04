class QualityAssuranceReviewsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityAssuranceReviewsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityAssuranceReviewsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityAssuranceReviewsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
