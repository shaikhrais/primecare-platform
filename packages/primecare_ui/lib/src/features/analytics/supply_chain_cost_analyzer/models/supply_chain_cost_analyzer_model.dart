class SupplyChainCostAnalyzerModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const SupplyChainCostAnalyzerModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  SupplyChainCostAnalyzerModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return SupplyChainCostAnalyzerModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
