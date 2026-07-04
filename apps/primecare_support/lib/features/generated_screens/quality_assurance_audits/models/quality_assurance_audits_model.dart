class QualityAssuranceAuditsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityAssuranceAuditsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityAssuranceAuditsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityAssuranceAuditsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
