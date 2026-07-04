class HeadOfMarketingComplianceModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfMarketingComplianceModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfMarketingComplianceModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfMarketingComplianceModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
