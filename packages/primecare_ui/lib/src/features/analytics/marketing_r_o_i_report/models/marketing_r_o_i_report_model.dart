class MarketingROIReportModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const MarketingROIReportModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  MarketingROIReportModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return MarketingROIReportModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
