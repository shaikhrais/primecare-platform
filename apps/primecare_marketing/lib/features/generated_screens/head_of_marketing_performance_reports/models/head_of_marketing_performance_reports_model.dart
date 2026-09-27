class HeadOfMarketingPerformanceReportsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const HeadOfMarketingPerformanceReportsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  HeadOfMarketingPerformanceReportsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return HeadOfMarketingPerformanceReportsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
