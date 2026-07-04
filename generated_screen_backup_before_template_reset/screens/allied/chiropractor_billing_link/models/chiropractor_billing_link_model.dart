class ChiropractorBillingLinkModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ChiropractorBillingLinkModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ChiropractorBillingLinkModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ChiropractorBillingLinkModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
