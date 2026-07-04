class CfoFinancialOverviewModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const CfoFinancialOverviewModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  CfoFinancialOverviewModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return CfoFinancialOverviewModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
