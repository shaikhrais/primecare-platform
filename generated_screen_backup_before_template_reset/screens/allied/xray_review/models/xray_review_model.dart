class XrayReviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const XrayReviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  XrayReviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return XrayReviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
