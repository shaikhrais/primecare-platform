class AccessReviewCertifierModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AccessReviewCertifierModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AccessReviewCertifierModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AccessReviewCertifierModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
