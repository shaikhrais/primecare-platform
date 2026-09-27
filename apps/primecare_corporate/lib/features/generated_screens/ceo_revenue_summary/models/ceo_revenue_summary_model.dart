class CeoRevenueSummaryModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CeoRevenueSummaryModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CeoRevenueSummaryModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CeoRevenueSummaryModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
