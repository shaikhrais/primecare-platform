class RpnCarePlanReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RpnCarePlanReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RpnCarePlanReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RpnCarePlanReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
