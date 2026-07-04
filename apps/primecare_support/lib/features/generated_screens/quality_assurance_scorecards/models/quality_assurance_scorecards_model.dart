class QualityAssuranceScorecardsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityAssuranceScorecardsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityAssuranceScorecardsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityAssuranceScorecardsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
