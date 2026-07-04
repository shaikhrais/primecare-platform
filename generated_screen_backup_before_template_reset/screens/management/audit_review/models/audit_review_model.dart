class AuditReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AuditReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AuditReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AuditReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
