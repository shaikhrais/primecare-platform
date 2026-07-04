class QualityAssuranceComplaintsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const QualityAssuranceComplaintsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  QualityAssuranceComplaintsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return QualityAssuranceComplaintsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
