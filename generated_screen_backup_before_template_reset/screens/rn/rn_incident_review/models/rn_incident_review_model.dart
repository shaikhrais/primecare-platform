class RnIncidentReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RnIncidentReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RnIncidentReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RnIncidentReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
